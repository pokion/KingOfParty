extends AspectRatioContainer

@export var gameMode: String = "Game mode"
@export var content: String = "Content"
@export var author: String = "author"

signal click;

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Panel/VBoxContainer/Game mode".text = gameMode
	$Panel/VBoxContainer/Content.text = content
	$Panel/VBoxContainer/Author.text = author

func setContent(text: String)->void:
	$Panel/VBoxContainer/Content.text = text;

func setGameMode(gameMode: String)->void:
	$"Panel/VBoxContainer/Game mode".text = gameMode
	
func setAuthor(author: String)->void:
	$Panel/VBoxContainer/Author.text = author


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print('asd')
		click.emit()
