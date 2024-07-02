extends AspectRatioContainer

@export var deckName = "Deck Name"
var selected = false
var pressPosition: Vector2

signal deckNamePropagate(name, isSelected)

func _ready():
	$Panel/DeckName.text = deckName

func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.button_mask == 1:
		pressPosition = event.position
	if event is InputEventMouseButton and event.button_mask == 0:
		if pressPosition.distance_to(event.position) < 5:
			selected = !selected
			deckNamePropagate.emit(deckName, selected)
			if selected:
				$Panel/Label.visible = true;
			else:
				$Panel/Label.visible = false;
