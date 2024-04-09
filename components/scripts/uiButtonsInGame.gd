extends Control

@export_enum("showCard","hiddenCard","startTimer","nextPlayer","showCardWithoudSkipButton") var setsButton: String = "showCard" 

var buttonSetsConst: Dictionary= {
		"showCard": "onShowCard",
		"hiddenCard": "onHiddenCard",
		"startTimer": "onStartTimer",
		"nextPlayer": "onNextPlayer",
		"showCardWithoudSkipButton": "onShowCardWithoutSkip",
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
