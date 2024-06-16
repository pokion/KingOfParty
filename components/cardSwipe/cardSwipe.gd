extends Node2D

@export var gameMode: String = "Game mode"
@export var content: String = "Content"
@export var author: String = "author"
@export var maxRotation: int = 20
@export var maxTimeToReturn: float = 0.5;
@export var isSwipeActive: bool = true;
var vieportSize;
var vieportSizeXHalf;
var isPressed = false;
var timeElapse = 0;
var initialDistance = 0;

func _ready():
	$Panel/MarginContainer/VBoxContainer/Content.text = content
	vieportSize = get_viewport().get_visible_rect().size
	vieportSizeXHalf = vieportSize.x/2
	self.position.y = vieportSize.y/2
	
func _process(delta):
	timeElapse += delta
	if not isPressed and self.position.x != vieportSizeXHalf:
		calculateReturnStep(timeElapse)
	calculateRotation()

func setContent(text: String)->void:
	$Panel/MarginContainer/VBoxContainer/Content.text = text;

func calculateRotation():
	var deegre = 0;
	if self.position.x >= vieportSize.x/2:
		deegre = remap(self.position.x, vieportSizeXHalf, vieportSize.x, 0, maxRotation)
	else:
		deegre = remap(self.position.x, 0, vieportSizeXHalf, -maxRotation, 0)
	self.rotation = deegre * PI / 180
	
func calculateReturnStep(timeElapsed):
	var newPosition = remap(timeElapsed, 0, maxTimeToReturn, initialDistance, vieportSizeXHalf );
	if newPosition > vieportSizeXHalf and self.position.x < vieportSizeXHalf:
		newPosition = vieportSizeXHalf
	if newPosition < vieportSizeXHalf and self.position.x > vieportSizeXHalf:
		newPosition = vieportSizeXHalf
	self.position.x = newPosition

func _on_gui_input(event):
	if event.button_mask == 1:
		isPressed = true;
	if event.button_mask == 0 and isPressed:
		timeElapse = 0;
		initialDistance = self.position.x;
		isPressed = false;
		
	if isSwipeActive and event is InputEventMouseMotion and event.button_mask == 1:
		var positionMouse = event.position
		self.position.x = get_global_mouse_position().x
		
