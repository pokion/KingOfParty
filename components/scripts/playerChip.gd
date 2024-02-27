extends PanelContainer

@export var fullName: String = "Andy";
@export var firstLetter: String = "A";
@export var colorBorder: Color = "#D96C6C";
@export var isExpanded: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$fullNameChip/fullName.text = fullName;
	$FirstLetterChip/firstLetter.text = firstLetter;
	changeVisibility(isExpanded)
	changeColor(colorBorder)

func changeVisibility(visibility: bool):
	isExpanded = visibility
	$fullNameChip.visible = isExpanded
	$FirstLetterChip.visible = !isExpanded

func changeColor(color: Color):
	var style = self.get_theme_stylebox("panel").duplicate()
	style.border_color = color
	self.add_theme_stylebox_override("panel", style)
