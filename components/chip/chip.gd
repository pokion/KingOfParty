extends PanelContainer

@export var nameChip: String = "Chip Name"
var chipStyle = preload("res://styles/chip.tres");
var chipFocusStyle = preload("res://styles/chipFocus.tres");
var isFocus = false;

func _ready():
	$MarginContainer/Label.text = nameChip

func _process(delta):
	pass

func _on_button_pressed():
	isFocus = !isFocus
	self.add_theme_stylebox_override("panel", chipFocusStyle if isFocus else chipStyle)
