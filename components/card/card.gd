extends AspectRatioContainer

@export var content: String = "Content"
@export var returnArgument: Dictionary = {}

signal click(exportArg);

func _ready():
	$Panel/VBoxContainer/Content.text = content

func setContent(text: String)->void:
	$Panel/VBoxContainer/Content.text = text;

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		click.emit(returnArgument)
