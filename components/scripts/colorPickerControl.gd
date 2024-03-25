extends Control

@export var objectRef = {}
@export var sceneRef = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.colorPickedPropagate.connect(onColorPicked)

func onColorPicked(color):
	if not (objectRef.is_empty()):
		objectRef.color = color
		sceneRef.changeColor(color)
		self.visible = false
