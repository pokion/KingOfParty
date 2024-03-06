extends Node2D

var playerDisplayComponent = preload("res://components/playerDisplay.tscn")
var players;
var colorPicker;
# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_node("/root/Players");
	colorPicker = $CanvasLayer/colorPickerControl;

func addPlayerToContainer(playerObject: Dictionary):
	var playerDisplayComponentNew = playerDisplayComponent.duplicate().instantiate()
	playerDisplayComponentNew.showColorpicker.connect(_on_changeColorButton)
	playerDisplayComponentNew.referenceObject = playerObject
	playerDisplayComponentNew.playerName = playerObject.name
	playerDisplayComponentNew.firstLetter = playerObject.firstLetter
	playerDisplayComponentNew.color = playerObject.color
	$CanvasLayer/VBoxContainer/ScrollContainer/PlayerContainer.add_child(playerDisplayComponentNew)

func _on_add_player_pressed():
	var playerName = $CanvasLayer/VBoxContainer/HBoxContainer/playerName.text
	addPlayerToContainer(players.addPlayer(playerName))
	$CanvasLayer/VBoxContainer/HBoxContainer/playerName.text = ""


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_changeColorButton(objectRef, sceneRef):
	colorPicker.visible = true;
	colorPicker.objectRef = objectRef
	colorPicker.sceneRef = sceneRef
