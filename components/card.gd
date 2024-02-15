extends AspectRatioContainer

@export var gameMode: String = "Game mode"
@export var content: String = "Content"
@export var author: String = "author"

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Panel/VBoxContainer/Game mode".text = gameMode
	$Panel/VBoxContainer/Content.text = content
	$Panel/VBoxContainer/Author.text = author


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
