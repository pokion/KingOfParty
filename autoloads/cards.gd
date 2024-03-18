extends Node

var cards = {}
var gameModes = {
	"neverever": "Never Ever",
	"whoami": "Who am I?",
	"truth|dare": "Truth or Dare",
	"seconds": "10 Seconds"
}

func _ready():
	importDataFromCsv("res://cards/cards.txt")
	#print(shuffleAndReturn(["neverever", "whoami", ["truth", "dare"],"seconds"]))
	
func getAllCards():
	return cards;
	
func shuffleAndReturn(nameOfGamemodes: Array, decks: Array = ["travel", "nerds"]) -> Array:
	var newArray = [];
	var tempArray = null;
	
	for deck in decks:
		if tempArray == null:
			tempArray = cards[deck]
		else:
			for gamemode in cards[deck]:
				tempArray[gamemode].append(cards[deck][gamemode])

	for name in nameOfGamemodes:
		if name is Array:
			var minimalSize = 0
			var joinedArray = []
			for indexName in name:
				minimalSize = tempArray[indexName].size();
				tempArray[indexName].shuffle();
			for index in minimalSize:
				var arrayToPush = []
				for indexName in name:
					arrayToPush.append(tempArray[indexName][index])
				joinedArray.append(arrayToPush)
			newArray += joinedArray;
		else:
			newArray += tempArray[name];
			
	newArray.shuffle();
	return newArray;

	
func importDataFromCsv(filePath):
	var file = FileAccess.open(filePath, FileAccess.READ)
	var objectStructure = file.get_csv_line()
	
	while !file.eof_reached():
		var data_set = Array(file.get_csv_line())
		var objectCard = {}
		if data_set.size() > 1:
			for index in objectStructure.size():
				objectCard[objectStructure[index]] = data_set[index]
			
		if not objectCard.is_empty():
			if not cards.has(objectCard["deck"]):
				cards[objectCard["deck"]] = {}
			if not cards[objectCard["deck"]].has(objectCard["gameMode"]):
				cards[objectCard["deck"]][objectCard["gameMode"]] = []
			cards[objectCard["deck"]][objectCard["gameMode"]].append(objectCard)
	file.close()
