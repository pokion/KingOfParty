extends Node

var gameModes: Array;
var decks: Array;
var gameType: String;

func getSettings():
	if OS.is_debug_build():
		return {
			"gameModes": ["neverever", "whoami", ["truth", "dare"], "seconds"],
			#"gameModes": [["truth", "dare"]],
			"decks": ["nerds", "travel"],
			"gameType": "gameType"
		}
	else:
		return {
			"gameModes": gameModes,
			"decks": decks,
			"gameType": gameType
		}

func saveSettings(modes: Array, decksPass: Array, gameTypePass: String):
	gameModes = modes;
	decks = decksPass;
	gameType = gameTypePass;
