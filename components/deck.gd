extends AspectRatioContainer

@export var deckName = "Deck Name"
@export var cardCount = "100"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/DeckName.text = deckName
	$Panel/HBoxContainer/CardsCounterDisplay.text = cardCount


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
