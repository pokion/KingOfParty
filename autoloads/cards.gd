extends Node

const savePath = "user://saveCard.save"
var cards = {}
var customCards = {}
var gameModes = {
	"neverever": "Never Ever",
	"whoami": "Who am I?",
	"truth|dare": "Truth or Dare",
	"seconds": "10 Seconds"
}

func _ready():
	importDataFromCsv("res://cards/cards.txt")
	loadCustomCards()
	
func getAllCards():
	return cards;
	
func getAllDecksNames() -> Array:
	return cards.keys()
	
func shuffleAndReturn(nameOfGamemodes: Array, decks: Array) -> Array:
	var newArray = [];
	var tempArray = null;
	
	for deck in decks:
		if tempArray == null:
			tempArray = cards[deck]
		else:
			for gamemode in cards[deck]:
				tempArray[gamemode] += cards[deck][gamemode]

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

func getCustomCards():
	return customCards;

func save(gameMode: String = "", object = null):
	if not gameMode.is_empty() and not object == null:
		if not customCards.has(gameMode):
			customCards[gameMode] = []
		customCards[gameMode].append(object)
	
	var saveCards = FileAccess.open(savePath, FileAccess.WRITE)
	var jsonData = JSON.stringify(customCards)
	saveCards.store_line(jsonData)
	cards["custom"] = customCards
	
func loadCustomCards():
	if not FileAccess.file_exists(savePath):
		return;
		
	var saveCards = FileAccess.open(savePath, FileAccess.READ)
	var jsonString = saveCards.get_line()
	var json = JSON.new();
	var parseResult = json.parse(jsonString)
	customCards = json.get_data()
	if customCards["dare"].size() <= 0 and customCards["neverever"].size() <= 0 and customCards["seconds"].size() <= 0 and customCards["truth"].size() <= 0 and customCards["whoami"].size() > 0:
		return;
	cards["custom"] = customCards

func removeCard(gameMode: String, object):
	customCards[gameMode].erase(object)
	self.save()
