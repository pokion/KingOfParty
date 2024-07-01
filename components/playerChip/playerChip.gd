extends PanelContainer

@export var fullName: String = "Andy";
@export var firstLetter: String = "A";
@export var colorBorder: Color = "#D96C6C";
@export var isExpanded: bool = false;
@export var stopParticle: bool = false;

signal chipPressed(referenceScene);

func _ready():
	$fullNameChip/fullName.text = fullName;
	$FirstLetterChip/firstLetter.text = firstLetter;
	changeVisibility(isExpanded)
	changeColor(colorBorder)
	if stopParticle == true:
		$FirstLetterChip/explosion.visible = false

func changeFirstLetter(letter: String)->void:
	$FirstLetterChip/firstLetter.text = letter

func changeVisibility(visibility: bool):
	isExpanded = visibility
	$fullNameChip.visible = isExpanded
	$FirstLetterChip.visible = !isExpanded

func changeColor(color: Color):
	var style = self.get_theme_stylebox("panel").duplicate()
	style.border_color = color
	self.add_theme_stylebox_override("panel", style)
	if stopParticle == false:
		$FirstLetterChip/explosion.changeParticleColor(color)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		chipPressed.emit(self);
