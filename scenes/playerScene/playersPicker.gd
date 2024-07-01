extends Control

var playerDisplayComponent = preload("res://components/playerDisplay/playerDisplay.tscn")
var players;
var colorPicker;

signal onErrorMessage(errorMessage: String)
signal onRemoveErrorMessage()

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

func _on_add_player_pressed(text : String = "nothing"):
	var playerName = $VBoxContainer/HBoxContainer/playerName.text
	playerName.strip_edges(true,true)
	if playerName.length() > 12:
		onErrorMessage.emit("Maksymalnie może być tylko 12 znaków")
		return;
	if playerName.length() == 0:
		onErrorMessage.emit("Musisz wpisać przynajmniej jeden znak")
		return;
	addPlayerToContainer(players.addPlayer(playerName))
	$VBoxContainer/HBoxContainer/playerName.text = ""
	onRemoveErrorMessage.emit()

func _on_changeColorButton(objectRef, sceneRef):
	colorPicker.visible = true;
	colorPicker.objectRef = objectRef
	colorPicker.sceneRef = sceneRef
