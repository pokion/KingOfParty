extends Control

@export_enum("showCard","hiddenCard","startTimer","nextPlayer") var setsButton: String = "showCard" 

var buttonSetsConst: Dictionary= {
		"showCard": "onShowCard",
		"hiddenCard": "onHiddenCard",
		"startTimer": "onStartTimer",
		"nextPlayer": "onNextPlayer"
	}

signal uiButton(mode: String)

func _ready():
	setButtons(setsButton)

func _on_button_pressed(mode):
	print(mode)
	uiButton.emit(mode)

func setButtons(newSet: String):
	get_node(buttonSetsConst[newSet]).visible = true;
	get_node(buttonSetsConst[setsButton]).visible = false;
	setsButton = newSet;
	
