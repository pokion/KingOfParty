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
		"showCardButton": $CanvasLayer/gameScene/showCardButton,
		"playerAnnoucmentCard": $CanvasLayer/gameScene/playerAnnoucmentCard,
		"truthDare": $CanvasLayer/gameScene/truthDareMode,
		"neverEver": $CanvasLayer/gameScene/neverEverMode,
		"nextPlayerButton": $CanvasLayer/gameScene/nextPlayerButton,
		"truthCard": $CanvasLayer/gameScene/truthDareMode/truth,
		"dareCard": $CanvasLayer/gameScene/truthDareMode/dare,
		"truthDareContentCard": $CanvasLayer/gameScene/truthDareMode/truthDareContentCard,
		"whoAmIMode": $CanvasLayer/gameScene/whoAmIMode,
		"whoAmICard": $CanvasLayer/gameScene/whoAmIMode/whoAmICard,
		"startTimerButton": $CanvasLayer/gameScene/startTimerButton,
		"secondsMode": $CanvasLayer/gameScene/secondsMode,
	}
	cardsController = get_node("/root/Cards");
	playersController = get_node("/root/Players");
	gameSettings = get_node("/root/GameSettings");
	cards = cardsController.shuffleAndReturn(gameSettings.getGameModes());
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
	showNodes(["secondsMode", "startTimerButton"]);
	$CanvasLayer/gameScene/secondsMode/secondsProgressBar.value = 10;
	$CanvasLayer/gameScene/secondsMode/secondContainer/secondsCard.setContent(currentCard["content"])

func showWhoAmIMode():
	showNodes(["whoAmIMode", "whoAmICard", "nextPlayerButton"])
	nodes["whoAmICard"].setContent(currentCard["content"])

func showTruthDareMode(truthOrDare):
	showNodes(["truthDare", "truthDareContentCard", "nextPlayerButton"])
	if currentCard[0]["gameMode"] == truthOrDare:
		nodes["truthDareContentCard"].setContent(currentCard[0]["content"])
	else:
		nodes["truthDareContentCard"].setContent(currentCard[1]["content"])

func showTruthDarePickingMode():
	showNodes(["truthDare", "truthCard", "dareCard"])

func showNeverEverMode():
	showNodes(["neverEver", "nextPlayerButton"])
	$CanvasLayer/gameScene/neverEverMode/neverEverCard.setContent(currentCard["content"])

func showPlayerMode():
	var hintForGameMode = "";
	if not (currentCard is Array):
		if hintsForNextMode.has(currentCard.gameMode):
			hintForGameMode = hintsForNextMode[currentCard.gameMode];
		
	$CanvasLayer/gameScene/playerAnnoucmentCard/playerTurn.text = players[players.keys()[currentPlayer]]["name"] + " turn";
	$CanvasLayer/gameScene/playerAnnoucmentCard/hint.text = hintForGameMode;
	showNodes(["showCardButton", "playerAnnoucmentCard"])

#Utilities
func showNodes(nodesName: Array[String]):
	for nodeName in nodesName:
		nodes[nodeName].visible = true;
		
func hideAllNodes():
	for node in nodes:
		nodes[node].visible = false
		
func addPlayersChips(players):
	for player in players:
		var playerChipDuplicated = playerChip.duplicate().instantiate();
		playerChipDuplicated.fullName = players[player].name
		playerChipDuplicated.firstLetter = players[player].firstLetter
		playerChipDuplicated.colorBorder = players[player].color
		$CanvasLayer/gameScene/playerContainer.add_child(playerChipDuplicated)
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
	currentCard = cards.pop_back();
	currentPlayer += 1;
	if currentPlayer == players.size():
		currentPlayer = 0;
	changeVisibilityOfNodes(SHOW_PLAYER_TURN);
	changePlayerChipViewToCurrentPlayer()

#this function catch signal form truth/dare button
func _on_dare_button(isTruth):
	if isTruth:
		changeVisibilityOfNodes(SHOW_TRUTH_SCENE);
	else:
		changeVisibilityOfNodes(SHOW_DARE_SCENE);


func _on_start_timer_button_pressed():
	nodes["startTimerButton"].visible = false;
	$CanvasLayer/gameScene/secondsMode/secondsTimer.start();


func _on_seconds_progress_bar_timer_empty():
	showNodes(["nextPlayerButton"]);
