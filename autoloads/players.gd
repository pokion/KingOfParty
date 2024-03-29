extends Node

var playersArray = {};
var colorsShuffled;
@export var colors = ["#D96C6C", "#F27141", "#FFFFFF", "#763838", "#8C3F54", "#C9E7F2", "#8C512E", "#A66E4E", "#F2A0ED", "#AE6BF2", "#3E3E40", "#85F2DE", "#F23D4C", "#F2B279", "#D98C5F", "#548DBF", "#66ADD9", "#6C7339", "#3F4021", "#A3A660"]
var colorIndex = 0;

func _ready():
	colorsShuffled = colors.duplicate();
	colors.shuffle();
	if OS.is_debug_build():
		putTestPlayers()

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
	
func putTestPlayers():
	playersArray["czarek"] = {"name": "czarek","points": 0,"firstLetter": "C","color": getRandomColor()}
	playersArray["patrycja"] = {"name": "patrycja","points": 0,"firstLetter": "P","color": getRandomColor()}
	
func getAllPlayers() -> Dictionary:
	return playersArray
