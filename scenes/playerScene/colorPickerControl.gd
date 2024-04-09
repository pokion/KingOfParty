extends Control

@export var objectRef = {}
@export var sceneRef = {}

func _ready():
	$Control.colorPickedPropagate.connect(onColorPicked)

func onColorPicked(color):
	if not (objectRef.is_empty()):
		objectRef.color = color
		sceneRef.changeColor(color)
		self.visible = false

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		self.visible = false;
