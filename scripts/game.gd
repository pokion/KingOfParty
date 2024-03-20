extends Node2D

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
	"whoami": "Put the phone to your forehead and click screen."
}

var cardsController;
var playersController;
var players;
var playersNodeReference = {};
var cards;
var currentCard;
var currentPlayer: int = -1;
var nodes
var gameSettings;

var playerChip = preload("res://components/playerChip.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = {
		"mainCard": $CanvasLayer/MarginContainer/gameScene/mainCard,
		"truthDareContainer": $CanvasLayer/MarginContainer/gameScene/truthDareContainer,
		"progressBar": $CanvasLayer/MarginContainer/gameScene/secondsProgressBar,
		"playerTurnAndHint": $CanvasLayer/MarginContainer/gameScene/playerTurnAndHint,
		#buttons
		"showCardButton": $CanvasLayer/MarginContainer/gameScene/showCardButton,
		"startTimerButton": $CanvasLayer/MarginContainer/gameScene/startTimerButton,
		"nextPlayerButton": $CanvasLayer/MarginContainer/gameScene/nextPlayerButton,
	}
	cardsController = get_node("/root/Cards");
	playersController = get_node("/root/Players");
	gameSettings = get_node("/root/GameSettings").getSettings();
	cards = cardsController.shuffleAndReturn(gameSettings["gameModes"], gameSettings["decks"]);
	players = playersController.getAllPlayers();
	addPlayersChips(players)
	onNextPlayer()
	changePlayerChipViewToCurrentPlayer()

func changeVisibilityOfNodes(state):
	hideAllNodes();
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
	showNodes(["progressBar", "startTimerButton", "mainCard"]);
	nodes["progressBar"].value = 10;
	nodes["mainCard"].setContent(currentCard["content"])
	nodes["mainCard"].setGameMode(currentCard["gameMode"])

func showWhoAmIMode():
	showNodes(["mainCard", "nextPlayerButton"])
	nodes["mainCard"].setContent(currentCard["content"])
	nodes["mainCard"].setGameMode(currentCard["gameMode"])

func showTruthDareMode(truthOrDare):
	showNodes(["mainCard", "nextPlayerButton"])
	if currentCard[0]["gameMode"] == truthOrDare:
		nodes["mainCard"].setContent(currentCard[0]["content"])
		nodes["mainCard"].setGameMode(currentCard[0]["gameMode"])
	else:
		nodes["mainCard"].setContent(currentCard[1]["content"])
		nodes["mainCard"].setGameMode(currentCard[1]["gameMode"])

func showTruthDarePickingMode():
	showNodes(["truthDareContainer"])

func showNeverEverMode():
	showNodes(["nextPlayerButton", "mainCard"])
	nodes["mainCard"].setContent(currentCard["content"])
	nodes["mainCard"].setGameMode(currentCard["gameMode"])

func showPlayerMode():
	var hintForGameMode = "";
	if not (currentCard is Array):
		if hintsForNextMode.has(currentCard.gameMode):
			hintForGameMode = hintsForNextMode[currentCard.gameMode];
		
	$CanvasLayer/MarginContainer/gameScene/playerTurnAndHint/playerTrun.text = players[players.keys()[currentPlayer]]["name"] + " turn";
	$CanvasLayer/MarginContainer/gameScene/playerTurnAndHint/hint.text = hintForGameMode;
	showNodes(["showCardButton", "playerTurnAndHint"])

#Utilities
func showNodes(nodesName: Array[String]):
	for nodeName in nodesName:
		nodes[nodeName].visible = true;
		
func hideAllNodes():
	for node in nodes:
		nodes[node].visible = false
		
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

#this function catch signal form truth/dare card
func _on_dare_button(isTruth):
	if isTruth:
		changeVisibilityOfNodes(SHOW_TRUTH_SCENE);
	else:
		changeVisibilityOfNodes(SHOW_DARE_SCENE);


func _on_start_timer_button_pressed():
	nodes["startTimerButton"].visible = false;
	$CanvasLayer/MarginContainer/gameScene/secondsProgressBar/Timer.start();


func _on_seconds_progress_bar_timer_empty():
	showNodes(["nextPlayerButton"]);
