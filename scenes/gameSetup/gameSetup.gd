extends Control

var pickedGameModes = [];
var step;
var currentStep = 0
var gameSettings;
var rules = [checkIfPlayerCheckedAtLeastOneGameMode, checkIfPlayerSelectAtLeastOneDeck, checkIfPlayerSelectAtLeastOnePlayer, checkIfPlayerSelectGameType];
var players;
var decks = []
var gameType = null
var titleNames = ["Wybierz tryb gry","Wybierz deki","Wpisz graczy"]

func _ready():
	gameSettings = get_node("/root/GameSettings")
	players = get_node("/root/Players")
	step = [$CanvasLayer/VBoxContainer/Control/gameModePicker,$CanvasLayer/VBoxContainer/Control/Decks,$CanvasLayer/VBoxContainer/Control/playerScene]
	
func checkIfPlayerCheckedAtLeastOneGameMode():
	if pickedGameModes.size() == 0:
		return "Musisz wybrać przynajmniej jeden tryb gry"
	else:
		return false;

func checkIfPlayerSelectAtLeastOnePlayer():
	if players.getAllPlayers().size() == 0:
		return "Musisz dodać przynajmniej jednego gracza"
	else:
		return false;
		
func checkIfPlayerSelectAtLeastOneDeck():
	if decks.size() == 0:
		return "Musisz wybrać przynajmniej jeden dek"
	else:
		return false;
		
func checkIfPlayerSelectGameType():
	if gameType == null:
		return "You need select game type."
	else:
		return false;
	
func setErrorMessage(message):
	$CanvasLayer/VBoxContainer/ErrorMessage.text = message;
	
func removeErrorMessage():
	setErrorMessage("")
	
func ruleToStep(direction):
	if direction == "next":
		var ruleText = rules[currentStep].call()
		if not (ruleText is bool):
			setErrorMessage(ruleText);
			return;
		next()
		setErrorMessage("")
		
	if direction == "prev":
		prev()
		setErrorMessage("")
	
func next():
	currentStep = currentStep + 1;
	if currentStep == step.size() - 1:
		$CanvasLayer/VBoxContainer/MarginContainer/HBoxContainer/startButton.visible = true;
		$CanvasLayer/VBoxContainer/MarginContainer/HBoxContainer/nextButton.visible = false;
	
	if currentStep > 0 and $CanvasLayer/VBoxContainer/MarginContainer/HBoxContainer/goToMenu.visible == true:
		$CanvasLayer/VBoxContainer/MarginContainer/HBoxContainer/goToMenu.visible = false
		$CanvasLayer/VBoxContainer/MarginContainer/HBoxContainer/previousButton.visible = true;
	
	step[currentStep - 1].visible = false;
	step[currentStep].visible = true;
	$CanvasLayer/VBoxContainer/labelMargin/titleLabel.text = titleNames[currentStep]
		
		
func prev():
	currentStep = currentStep - 1;
	if currentStep == 0:
		$CanvasLayer/VBoxContainer/MarginContainer/HBoxContainer/goToMenu.visible = true;
		$CanvasLayer/VBoxContainer/MarginContainer/HBoxContainer/previousButton.visible = false;
	
	if currentStep < step.size() - 1 and $CanvasLayer/VBoxContainer/MarginContainer/HBoxContainer/startButton.visible == true:
		$CanvasLayer/VBoxContainer/MarginContainer/HBoxContainer/startButton.visible = false;
		$CanvasLayer/VBoxContainer/MarginContainer/HBoxContainer/nextButton.visible = true;
	
	step[currentStep + 1].visible = false;
	step[currentStep].visible = true;
	$CanvasLayer/VBoxContainer/labelMargin/titleLabel.text = titleNames[currentStep]
	
func backToMenu():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
	
func startGame():
	var ruleText = rules[currentStep].call()
	if not (ruleText is bool):
		setErrorMessage(ruleText);
		return;
	gameSettings.saveSettings(pickedGameModes, decks, "gameType")#usunąć string tutaj
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _on_game_mode_picker_on_game_mode_toggle(isTrue, gameMode):
	if isTrue:
		pickedGameModes.append(gameMode)
	else:
		pickedGameModes.erase(gameMode)

func _on_decks_deck_name(deck):
	decks = deck;

func _on_game_type_send_selected(gameTypeName):
	gameType = gameTypeName;
