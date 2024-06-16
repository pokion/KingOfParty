extends Control

@export_enum("showCard","startTimer","show") var setsButton: String = "showCard" 

var buttonSetsConst: Dictionary= {
		"showCard": "onShowCard",
		"startTimer": "onStartTimer",
		"show": "onShow"
	}

signal uiButton(mode: String)

func _ready():
	setButtons(setsButton)

func _on_button_pressed(mode):
	uiButton.emit(mode)
	
func hideAllGroups():
	for buttonSetName in buttonSetsConst:
		get_node(buttonSetsConst[buttonSetName]).visible = false;

func setButtons(newSet: String):
	hideAllGroups();
	get_node(buttonSetsConst[newSet]).visible = true;
	setsButton = newSet;

