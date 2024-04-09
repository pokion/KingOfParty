extends Control

var playerDisplayComponent = preload("res://components/playerDisplay/playerDisplay.tscn")
var players;
var colorPicker;
# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_node("/root/Players");
	colorPicker = $colorPickerControl;

func addPlayerToContainer(playerObject: Dictionary):
	var playerDisplayComponentNew = playerDisplayComponent.duplicate().instantiate()
	playerDisplayComponentNew.showColorpicker.connect(_on_changeColorButton)
	playerDisplayComponentNew.referenceObject = playerObject
	playerDisplayComponentNew.playerName = playerObject.name
	playerDisplayComponentNew.firstLetter = playerObject.firstLetter
	playerDisplayComponentNew.color = playerObject.color
	$VBoxContainer/ScrollContainer/PlayerContainer.add_child(playerDisplayComponentNew)

func _on_add_player_pressed():
	var playerName = $VBoxContainer/HBoxContainer/playerName.text
	addPlayerToContainer(players.addPlayer(playerName))
	$VBoxContainer/HBoxContainer/playerName.text = ""

func _on_changeColorButton(objectRef, sceneRef):
	colorPicker.visible = true;
	colorPicker.objectRef = objectRef
	colorPicker.sceneRef = sceneRef
