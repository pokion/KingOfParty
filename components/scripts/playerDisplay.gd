extends HBoxContainer

@export var playerName: String = "Andy"
@export var firstLetter: String = "A"
@export var color: Color = "#D96C6C"

# Called when the node enters the scene tree for the first time.
func _ready():
	$name.text = playerName
	$firstLetter.text = firstLetter
	var style = $firstLetter.get_theme_stylebox("normal").duplicate()
	style.border_color = color
	$firstLetter.add_theme_stylebox_override("normal", style)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
