extends Control;

var decks = []
var selectedDecks = []
signal deckName(deck)

func _ready():
	var decksNames = get_node("/root/Cards").getAllCards();
	for deckname in decksNames:
		decks.append(deckname)
	var hiddenDeck = $HiddenDeck
	var deckDispaly = $VBoxContainer/ScrollContainer/decksDisplay
	for deckNameI in decks:
		var newDeck = hiddenDeck.duplicate()
		newDeck.deckName = deckNameI
		newDeck.visible = true
		deckDispaly.add_child(newDeck)

func _on_hidden_deck_deck_name_propagate(nameDeck, selected):
	if not selected:
		selectedDecks.erase(nameDeck)
	else:
		selectedDecks.append(nameDeck)
	deckName.emit(selectedDecks);
