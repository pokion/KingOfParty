extends Node2D

var playerDisplayComponent = preload("res://components/playerDisplay.tscn")
var players;
# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_node("/root/Players");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_add_player_pressed():
	var playerName = $CanvasLayer/VBoxContainer/HBoxContainer/playerName.text
	var playerObject = players.addPlayer(playerName);
	var playerDisplayComponentNew = playerDisplayComponent.duplicate().instantiate()
	playerDisplayComponentNew.playerName = playerObject.name
	playerDisplayComponentNew.firstLetter = playerObject.firstLetter
	playerDisplayComponentNew.color = playerObject.color
	$CanvasLayer/VBoxContainer/ScrollContainer/PlayerContainer.add_child(playerDisplayComponentNew)
	$CanvasLayer/VBoxContainer/HBoxContainer/playerName.text = ""
