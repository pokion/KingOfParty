extends Node

var playersArray = {};
var colorsShuffled;
@export var colors = ["#D96C6C", "#F27141", "#FFFFFF", "#763838", "#8C3F54", "#C9E7F2", "#8C512E", "#A66E4E", "#F2A0ED", "#AE6BF2", "#3E3E40", "#85F2DE", "#F23D4C", "#F2B279", "#D98C5F", "#548DBF", "#66ADD9", "#6C7339", "#3F4021", "#A3A660"]
var colorIndex = 0;

func _ready():
	colorsShuffled = colors.duplicate();
	colors.shuffle();

func addPlayer(name: String) -> Dictionary:
	var player = {
		"name": name,
		"points": 0,
		"firstLetter": name[0].to_upper(),
		"color": getRandomColor()
	}
	playersArray[name] = player;
	return player;

func getRandomColor():
	if colorIndex > colors.size()-1:
		colorIndex = 0;
	else:
		colorIndex = colorIndex + 1;
	return colors[colorIndex]

func getAllColors():
	return colorsShuffled;

func clearPlayers() -> void:
	playersArray = {}
	
func getAllPlayers() -> Dictionary:
	if playersArray.is_empty():
		#test players
		playersArray["test"] = {"name": "name","points": 0,"firstLetter": "N","color": getRandomColor()}
		playersArray["test2"] = {"name": "admin","points": 0,"firstLetter": "A","color": getRandomColor()}
	return playersArray
