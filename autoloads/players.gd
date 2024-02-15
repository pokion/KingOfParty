extends Node

var playersArray = {};
var colors = ["#D96C6C", "#F27141", "#FFFFFF", "#763838"]

func addPlayer(name: String) -> Dictionary:
	var player = {
		"name": name,
		"points": 0,
		"firstLetter": name[0].to_upper(),
		"color": colors.pick_random()
	}
	playersArray[name] = player;
	return player;

func clearPlayers() -> void:
	playersArray = {}
	
func getAllPlayers() -> Dictionary:
	if playersArray.is_empty():
		#test players
		playersArray["test"] = {"name": "name","points": 0,"firstLetter": "N","color": colors.pick_random()}
		playersArray["test2"] = {"name": "admin","points": 0,"firstLetter": "A","color": colors.pick_random()}
	return playersArray
