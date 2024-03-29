extends AspectRatioContainer

@export var deckName = "Deck Name"
var selected = false

signal deckNamePropagate(name, isSelected)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/DeckName.text = deckName

func _on_panel_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		selected = !selected
		deckNamePropagate.emit(deckName, selected)
		if selected:
			$Panel/Label.visible = true;
		else:
			$Panel/Label.visible = false;
