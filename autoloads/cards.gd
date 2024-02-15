extends Node

var cards = {}

func _ready():
	importDataFromCsv("res://cards/cards.txt")
	#print(shuffleAndReturn(["neverever", "whoami", ["truth", "dare"],"seconds"]))
	
func getAllCards():
	return cards;
	
func shuffleAndReturn(nameOfGamemodes: Array) -> Array:
	var newArray = [];
	for name in nameOfGamemodes:
		if name is Array:
			var minimalSize = 0
			var joinedArray = []
			for indexName in name:
				minimalSize = cards[indexName].size();
				cards[indexName].shuffle();
			for index in minimalSize:
				var arrayToPush = []
				for indexName in name:
					arrayToPush.append(cards[indexName][index])
				joinedArray.append(arrayToPush)
			newArray += joinedArray;
		else:
			newArray += cards[name];
			
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
			if not cards.has(objectCard["gameMode"]):
				cards[objectCard["gameMode"]] = []
			cards[objectCard["gameMode"]].append(objectCard)
	file.close()
