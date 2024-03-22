extends Node2D

@export var gameMode: String = "Game mode"
@export var content: String = "Content"
@export var author: String = "author"
@export var maxRotation: int = 20
@export var maxTimeToReturn: float = 0.5;
var vieportSize;
var isPressed = false;
var timeElapse = 0;
var initialDistance = 0;

func _ready():
	$"Panel/VBoxContainer/Game mode".text = gameMode
	$Panel/VBoxContainer/Content.text = content
	$Panel/VBoxContainer/Author.text = author
	vieportSize = get_viewport().size
	self.position.x = vieportSize.x/2
	
func _process(delta):
	timeElapse += delta
	if self.position.x != vieportSize.x/2 and not isPressed:
		calculateReturnStep(timeElapse)
	calculateRotation()

func setContent(text: String)->void:
	$Panel/VBoxContainer/Content.text = text;

func setGameMode(gameMode: String)->void:
	$"Panel/VBoxContainer/Game mode".text = gameMode
	
func setAuthor(author: String)->void:
	$Panel/VBoxContainer/Author.text = author

func calculateRotation():
	var deegre = 0;
	if self.position.x >= vieportSize.x/2:
		deegre = remap(self.position.x, vieportSize.x/2, vieportSize.x, 0, maxRotation)
	else:
		deegre = remap(self.position.x, 0, vieportSize.x/2, -maxRotation, 0)
	self.rotation = deegre * PI / 180
	
func calculateReturnStep(timeElapsed):
	print(remap(timeElapsed, 0, maxTimeToReturn, initialDistance, (vieportSize.x/2)))
	self.position.x = remap(timeElapsed, 0, maxTimeToReturn, initialDistance, (vieportSize.x/2))

func _on_gui_input(event):
	if event.button_mask == 1:
		isPressed = true;
	if event.button_mask != 1:
		timeElapse = 0;
		initialDistance = self.position.x;
		isPressed = false;
		
	if event is InputEventMouseMotion and event.button_mask == 1:
		var positionMouse = event.position
		self.position.x = get_global_mouse_position().x
		
