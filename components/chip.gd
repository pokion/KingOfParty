extends PanelContainer

@export var nameChip: String = "Chip Name"
var chipStyle = preload("res://styles/chip.tres");
var chipFocusStyle = preload("res://styles/chipFocus.tres");
var isFocus = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/Label.text = nameChip

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	isFocus = !isFocus
	self.add_theme_stylebox_override("panel", chipFocusStyle if isFocus else chipStyle)
