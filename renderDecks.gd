extends Node2D

var decks = [
	{"name": "test1", "cardCount": 30},
	{"name": "test2", "cardCount": 35},
	{"name": "test3", "cardCount": 50},
	{"name": "test4", "cardCount": 111},
	{"name": "test5", "cardCount": 50},
	{"name": "test6", "cardCount": 99},
	{"name": "test7", "cardCount": 69},
	{"name": "test8", "cardCount": 420},
	{"name": "test9", "cardCount": 4230}
]
# Called when the node enters the scene tree for the first time.
func _ready():
	var hiddenDeck = $HiddenDeck
	var deckDispaly = $CanvasLayer/VBoxContainer/ScrollContainer/decksDisplay
	for deck in decks:
		var newDeck = hiddenDeck.duplicate()
		newDeck.deckName = deck.name
		newDeck.cardCount = str(deck.cardCount)
		newDeck.visible = true
		deckDispaly.add_child(newDeck)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
