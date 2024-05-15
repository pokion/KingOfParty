extends Area2D

@export var isLeft: bool = false: set = setPosition
@export var offsetFromCenter: int = 200: set = setOffset

func _init():
	setPosition(isLeft)
	var vieportSize = DisplayServer.window_get_size()
	var offsetCalculate = vieportSize.y/2
	self.position.y = offsetCalculate

func setPosition(value: bool):
	isLeft = value
	setOffset(offsetFromCenter);

func setOffset(value: int):
	var vieportSize = DisplayServer.window_get_size()
	var offsetCalculate = (vieportSize.x/2 - value) if isLeft else (vieportSize.x/2 + value)
	self.position.x = offsetCalculate
	offsetFromCenter = value
