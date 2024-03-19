extends Node

var gameModes: Array;
var decks: Array;
var gameType: String;

func getSettings():
	return {
		"gameModes": gameModes,
		"decks": decks,
		"gameType": gameType
	}

func saveSettings(modes: Array, decksPass: Array, gameTypePass: String):
	gameModes = modes;
	decks = decksPass;
	gameType = gameTypePass;
