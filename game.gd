extends Node2D

enum {
	SHOW_PLAYER_TURN,
	SHOW_NEVER_EVER_SCENE,
	SHOW_TRUTH_DARE_SCENE,
	SHOW_TRUTH_SCENE,
	SHOW_DARE_SCENE,
	SHOW_WHOAMI_SCENE,
}
var gameModeToEnums = {
	"neverever": SHOW_NEVER_EVER_SCENE,
	"truthDare": SHOW_TRUTH_DARE_SCENE,
	"whoami": SHOW_WHOAMI_SCENE,
}
var cardsController;
var playersController;
var players;
var cards;
var currentCard;
var currentPlayer: int = 0;
var nodes

# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = {
		"showCardButton": $CanvasLayer/gameScene/showCardButton,
		"playerAnnoucmentCard": $CanvasLayer/gameScene/playerAnnoucmentCard,
		"playerNameAnnoucment": $CanvasLayer/gameScene/playerAnnoucmentCard/playerNameAnnoucment,
		"truthDare": $CanvasLayer/gameScene/truthDareMode,
		"neverEver": $CanvasLayer/gameScene/neverEverMode,
		"nextPlayerButton": $CanvasLayer/gameScene/nextPlayerButton,
		"truthCard": $CanvasLayer/gameScene/truthDareMode/truth,
		"dareCard": $CanvasLayer/gameScene/truthDareMode/dare,
		"truthDareContentCard": $CanvasLayer/gameScene/truthDareMode/truthDareContentCard,
		"whoAmIMode": $CanvasLayer/gameScene/whoAmIMode,
		"whoAmICard": $CanvasLayer/gameScene/whoAmIMode/whoAmICard,
	}
	cardsController = get_node("/root/Cards");
	playersController = get_node("/root/Players");
	#cards = cardsController.shuffleAndReturn(["neverever", "whoami", ["truth", "dare"],"seconds"]);
	cards = cardsController.shuffleAndReturn(["whoami"]);
	players = playersController.getAllPlayers();
	changeVisibilityOfNodes(SHOW_PLAYER_TURN);

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

#Mode changers
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
	nodes["playerNameAnnoucment"].setContent(players[players.keys()[currentPlayer]]["name"])
	showNodes(["showCardButton", "playerNameAnnoucment", "playerAnnoucmentCard"])

#Utilities
func showNodes(nodesName: Array[String]):
	for nodeName in nodesName:
		nodes[nodeName].visible = true;
		
func hideAllNodes():
	for node in nodes:
		nodes[node].visible = false

#Signals
func _on_show_card_button_pressed():
	currentCard = cards.pop_back()
	if currentCard is Array:
		changeVisibilityOfNodes(SHOW_TRUTH_DARE_SCENE)
	else:
		changeVisibilityOfNodes(gameModeToEnums[currentCard["gameMode"]])


func onNextPlayer():
	currentPlayer += 1;
	if currentPlayer == players.size():
		currentPlayer = 0;
	changeVisibilityOfNodes(SHOW_PLAYER_TURN);

#this function catch signal form truth/dare button
func _on_dare_button(isTruth):
	if isTruth:
		changeVisibilityOfNodes(SHOW_TRUTH_SCENE);
	else:
		changeVisibilityOfNodes(SHOW_DARE_SCENE);
