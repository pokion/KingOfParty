extends Control;

var decks = []
var selectedDecks = []
signal deckName(deck)
# Called when the node enters the scene tree for the first time.
func _ready():
	var decksNames = get_node("/root/Cards").getAllCards();
	for deckname in decksNames:
		decks.append(deckname)

	var hiddenDeck = $HiddenDeck
	var deckDispaly = $VBoxContainer/ScrollContainer/decksDisplay
	for deckName in decks:
		var newDeck = hiddenDeck.duplicate()
		newDeck.deckName = deckName
		newDeck.visible = true
		deckDispaly.add_child(newDeck)

func _on_hidden_deck_deck_name_propagate(name, selected):
	if not selected:
		selectedDecks.erase(name)
	else:
		selectedDecks.append(name)
	deckName.emit(selectedDecks);
