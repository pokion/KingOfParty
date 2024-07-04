extends Node

var playersArray = {};
var colorsShuffled;
@export var colors = ["#D96C6C", "#F27141", "#FFFFFF", "#763838", "#8C3F54", "#C9E7F2", "#8C512E", "#A66E4E", "#F2A0ED", "#AE6BF2", "#3E3E40", "#85F2DE", "#F23D4C", "#F2B279", "#D98C5F", "#548DBF", "#66ADD9", "#6C7339", "#3F4021", "#A3A660"]
var colorIndex = 0;

func _ready():
	colorsShuffled = colors.duplicate();
	colors.shuffle();

func addPlayer(namePlayer: String):
	if playersArray.has(namePlayer):
		return "Gracz o takiej nazwie już istnieje"
	var player = {
		"name": namePlayer,
		"points": 0,
		"firstLetter": namePlayer[0].to_upper(),
		"color": getRandomColor()
	}
	playersArray[namePlayer] = player;
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
	playersArray["patryk"] = {"name": "patryk","points": 0,"firstLetter": "P","color": getRandomColor()}
	playersArray["andrzej"] = {"name": "andrzej","points": 0,"firstLetter": "A","color": getRandomColor()}
	playersArray["Marcin"] = {"name": "Marcin","points": 0,"firstLetter": "M","color": getRandomColor()}
	playersArray["Wojtek"] = {"name": "Wojtek","points": 0,"firstLetter": "W","color": getRandomColor()}
	
func getAllPlayers() -> Dictionary:
	if OS.is_debug_build() and playersArray.size() == 0:
		putTestPlayers()
	return playersArray
