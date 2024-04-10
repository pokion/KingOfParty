extends HBoxContainer

@export var playerName: String = "Andy"
@export var firstLetter: String = "A"
@export var color: Color = "#D96C6C"
@export var referenceObject = {}

signal showColorpicker(objectReference, sceneReference);

# Called when the node enters the scene tree for the first time.
func _ready():
	$name.text = playerName
	$PanelContainer.changeFirstLetter(firstLetter)
	$PanelContainer.changeColor(color)

func _on_panel_container_chip_pressed(referenceScene):
	showColorpicker.emit(referenceObject, referenceScene)
