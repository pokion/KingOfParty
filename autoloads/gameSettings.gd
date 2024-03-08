extends Node

var gameModes: Array;
var decks = [];
var gameType = [];

func setGameModes(gameModesArr: Array) -> void:
	gameModes = gameModesArr;
	
func getGameModes() -> Array:
	return gameModes;

