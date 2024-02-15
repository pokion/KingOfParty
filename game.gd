extends Node2D

enum {
	SHOW_PLAYER_TURN,
	SHOW_NEVER_EVER_SCENE,
	SHOW_TRUTH_DARE_SCENE
}
var gameModeToEnums = {
	"neverever": SHOW_NEVER_EVER_SCENE,
	"truthDare": SHOW_TRUTH_DARE_SCENE
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
		"neverEverButton": $CanvasLayer/gameScene/neverEverButton
	}
	cardsController = get_node("/root/Cards");
	playersController = get_node("/root/Players");
	#cards = cardsController.shuffleAndReturn(["neverever", "whoami", ["truth", "dare"],"seconds"]);
	cards = cardsController.shuffleAndReturn([["truth", "dare"]]);
	players = playersController.getAllPlayers();
	changeVisibilityOfNodes(SHOW_PLAYER_TURN)

func changeVisibilityOfNodes(state):
	hideAllNodes();
	match state:
		SHOW_PLAYER_TURN:
			showPlayerMode();
		SHOW_NEVER_EVER_SCENE:
			showNeverEverMode();
		SHOW_TRUTH_DARE_SCENE:
			showTruthDareMode();

#Mode changers
func showTruthDareMode():
	showNodes(["truthDare"])

func showNeverEverMode():
	showNodes(["neverEver", "neverEverButton"])
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


func _on_dare_gui_input(event):
	print(event)
	if (event is InputEventMouseButton && event.pressed && event.button_index == 1):
		print("Clicked")
