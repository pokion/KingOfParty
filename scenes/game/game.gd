extends Node2D

const Utils = preload("res://scripts/utils.gd")
const playerChip = preload("res://components/playerChip/playerChip.tscn");

enum {
	SHOW_PLAYER_TURN,
	SHOW_NEVER_EVER_SCENE,
	SHOW_TRUTH_DARE_SCENE,
	SHOW_TRUTH_SCENE,
	SHOW_DARE_SCENE,
	SHOW_WHOAMI_SCENE,
	SHOW_SECONDS_SCENE,
}
var gameModeToEnums = {
	"neverever": SHOW_NEVER_EVER_SCENE,
	"truthDare": SHOW_TRUTH_DARE_SCENE,
	"whoami": SHOW_WHOAMI_SCENE,
	"seconds": SHOW_SECONDS_SCENE,
}

var hintsForNextMode = {
	"seconds": "Pass phone to next player.",
	"whoami": "Put the phone to your forehead and click the screen."
}
#autoloads
var cardsController;
var playersController;
var gameSettings;

var players;
var playersNodeReference = {};
var cards;
var currentCard;
var currentPlayer: int = -1;
var nodes
var isRejectedAreaNow = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = {
		"mainCard": $CanvasLayer/mainCard,
		"truthDareContainer": $CanvasLayer/MarginContainer/gameScene/truthDareContainer,
		"progressBar": $CanvasLayer/MarginContainer/gameScene/secondsProgressBar,
		"playerTurnAndHint": $CanvasLayer/MarginContainer/gameScene/playerTurnAndHint,
		"rejectArea": $rejectArea,
		"completeArea": $completeArea,
		"skipButton": $CanvasLayer/skipButton
	}
	cardsController = get_node("/root/Cards");
	playersController = get_node("/root/Players");
	gameSettings = get_node("/root/GameSettings").getSettings();
	cards = cardsController.shuffleAndReturn(gameSettings["gameModes"], gameSettings["decks"]);
	players = playersController.getAllPlayers();
	addPlayersChips(players)
	onNextPlayer()
	changePlayerChipViewToCurrentPlayer()

func _process(delta):
	if isRejectedAreaNow != null and Input.is_action_just_released("mouseClick"):
		isRejectedAreaNow = null
		onNextPlayer()
			
func changeVisibilityOfNodes(state):
	Utils.hideNodes(nodes.values() as Array[Node]);
	nodes["mainCard"].isSwipeActive = true;
	match state:
		SHOW_PLAYER_TURN:
			showPlayerMode();
		SHOW_NEVER_EVER_SCENE:
			showNeverEverMode();
		SHOW_TRUTH_DARE_SCENE:
			showTruthDarePickingMode();
		SHOW_TRUTH_SCENE:
			showTruthDareMode("truth");
		SHOW_DARE_SCENE:
			showTruthDareMode("dare");
		SHOW_WHOAMI_SCENE:
			showWhoAmIMode();
		SHOW_SECONDS_SCENE:
			showSecondsMode();
			
#Mode changers
func showSecondsMode():
	Utils.showNodes([nodes["progressBar"], nodes["mainCard"]]);
	nodes["progressBar"].value = 10;
	nodes["mainCard"].setContent(currentCard["content"])
	nodes["mainCard"].setGameMode(currentCard["gameMode"])
	nodes["mainCard"].isSwipeActive = false
	$CanvasLayer/uiButtonsInGame.setButtons("startTimer")

func showWhoAmIMode():
	Utils.showNodes([nodes["mainCard"], nodes["rejectArea"], nodes["completeArea"]])
	nodes["mainCard"].setContent(currentCard["content"])
	nodes["mainCard"].setGameMode(currentCard["gameMode"])
	$CanvasLayer/uiButtonsInGame.setButtons("showCardWithoudSkipButton")

func showTruthDareMode(truthOrDare):
	Utils.showNodes([nodes["mainCard"], nodes["rejectArea"], nodes["completeArea"]])
	if currentCard[0]["gameMode"] == truthOrDare:
		nodes["mainCard"].setContent(currentCard[0]["content"])
		nodes["mainCard"].setGameMode(currentCard[0]["gameMode"])
	else:
		nodes["mainCard"].setContent(currentCard[1]["content"])
		nodes["mainCard"].setGameMode(currentCard[1]["gameMode"])
	$CanvasLayer/uiButtonsInGame.setButtons("showCard")

func showTruthDarePickingMode():
	Utils.showNodes([nodes["truthDareContainer"]])

func showNeverEverMode():
	Utils.showNodes([nodes["mainCard"], nodes["rejectArea"], nodes["completeArea"]])
	nodes["mainCard"].setContent(currentCard["content"])
	nodes["mainCard"].setGameMode(currentCard["gameMode"])
	$CanvasLayer/uiButtonsInGame.setButtons("showCard")

func showPlayerMode():
	var hintForGameMode = "";
	if not (currentCard is Array):
		if hintsForNextMode.has(currentCard.gameMode):
			if currentCard.gameMode == "whoami":
				nodes["skipButton"].visible = true;
			hintForGameMode = hintsForNextMode[currentCard.gameMode];
		
	$CanvasLayer/MarginContainer/gameScene/playerTurnAndHint/playerTrun.text = players[players.keys()[currentPlayer]]["name"] + " turn";
	$CanvasLayer/MarginContainer/gameScene/playerTurnAndHint/hint.text = hintForGameMode;
	Utils.showNodes([nodes["playerTurnAndHint"]])
	$CanvasLayer/uiButtonsInGame.setButtons("hiddenCard")

#Utilities
func addPlayersChips(players):
	var playerContainer = $CanvasLayer/MarginContainer/gameScene/playerContainer;
	for player in players:
		var playerChipDuplicated = playerChip.duplicate().instantiate();
		playerChipDuplicated.fullName = players[player].name
		playerChipDuplicated.firstLetter = players[player].firstLetter
		playerChipDuplicated.colorBorder = players[player].color
		playerContainer.add_child(playerChipDuplicated);
		playersNodeReference[player] = playerChipDuplicated;

func changePlayerChipViewToCurrentPlayer():
	playersNodeReference[players.keys()[currentPlayer]].changeVisibility(true)
	if currentPlayer == 0:
		playersNodeReference[players.keys()[players.size() - 1]].changeVisibility(false)
	else:
		playersNodeReference[players.keys()[currentPlayer - 1]].changeVisibility(false)

#Signals
func _on_show_card_button_pressed():
	if currentCard is Array:
		changeVisibilityOfNodes(SHOW_TRUTH_DARE_SCENE)
	else:
		changeVisibilityOfNodes(gameModeToEnums[currentCard["gameMode"]])

func onNextPlayer():
	if cards.size() <= 1:
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
		return;
	currentCard = cards.pop_back();
	currentPlayer += 1;
	if currentPlayer == players.size():
		currentPlayer = 0;
	changeVisibilityOfNodes(SHOW_PLAYER_TURN);
	changePlayerChipViewToCurrentPlayer()

func _on_skip_card():
	cards.append(currentCard)
	cards.shuffle()
	currentCard = cards.pop_back();
	changeVisibilityOfNodes(SHOW_PLAYER_TURN);

#this function catch signal form truth/dare card
func _on_dare_button(isTruth):
	if isTruth:
		changeVisibilityOfNodes(SHOW_TRUTH_SCENE);
	else:
		changeVisibilityOfNodes(SHOW_DARE_SCENE);

func _on_start_timer_button_pressed():
	$CanvasLayer/MarginContainer/gameScene/secondsProgressBar/Timer.start();

func _on_seconds_progress_bar_timer_empty():
	$CanvasLayer/uiButtonsInGame.visible = true;
	$CanvasLayer/uiButtonsInGame.setButtons("showCardWithoudSkipButton")

#isRejectedArea returns true only if its a rejected area
func _on_entered(area, isRejectedArea):
	isRejectedAreaNow = isRejectedArea

func _on_exited(area):
	isRejectedAreaNow = null;

func _on_ui_buttons(mode):
	print(mode)
	match mode:
		"accept":
			onNextPlayer()
		"skip":
			_on_skip_card()
		"decline":
			onNextPlayer()
		"show":
			_on_show_card_button_pressed()
		"startTimer":
			_on_start_timer_button_pressed()
			$CanvasLayer/uiButtonsInGame.visible = false;

func _on_skip_button_pressed():
	_on_show_card_button_pressed();
	nodes["skipButton"].visible = false
