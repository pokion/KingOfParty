extends CanvasLayer

var buttonPressed = "neverever";
var cards;
var cardsController;
var cardTemplate = preload("res://components/card/card.tscn").instantiate()
var utils = preload("res://scripts/utils.gd");

func _ready():
	cardsController = get_node("/root/Cards");
	cards = cardsController.getCustomCards();
	displayCards(cards[buttonPressed])

func displayCards(cardsArray: Array):
	utils.removeAllNodes($VBoxContainer/allCustomCards/ScrollContainer/cardContent)
		
	for card in cardsArray:
		var cardTemplateNew = cardTemplate.duplicate()
		cardTemplateNew.content = card.content
		cardTemplateNew.returnArgument = card;
		cardTemplateNew.click.connect(removeCard)
		$VBoxContainer/allCustomCards/ScrollContainer/cardContent.add_child(cardTemplateNew)

func _on_button_pressed(buttonName):
	$VBoxContainer/ScrollContainer/buttons/HBoxContainer.find_child(buttonPressed).disabled = false;
	$VBoxContainer/ScrollContainer/buttons/HBoxContainer.find_child(buttonName).disabled = true;
	buttonPressed = buttonName;
	
	if buttonName != "truth|dare":
		if cards.has(buttonPressed):
			displayCards(cards[buttonPressed])
		else:
			utils.removeAllNodes($CanvasLayer/VBoxContainer/allCustomCards/ScrollContainer/cardContent)
		$VBoxContainer/addCard/truthDare.visible = false;
		$VBoxContainer/addCard/addCard.visible = true;
	else:
		if cards.has("truth") and cards.has("dare"):
			var tempArray = cards["truth"];
			tempArray += cards["dare"];
			displayCards(tempArray)
		$VBoxContainer/addCard/truthDare.visible = true;
		$VBoxContainer/addCard/addCard.visible = false;
	buttonPressed = buttonName;

func save(_strPass: String = "d"):
	var text = $VBoxContainer/addCard/addCard/LineEdit.text
	if not text.is_empty():
		cardsController.save(buttonPressed, {"gameMode": buttonPressed, "content": text, "deck": "custom"})
	_on_button_pressed(buttonPressed)
	$VBoxContainer/addCard/addCard/LineEdit.text = ""
	
func saveTruthDare():
	var truth = $VBoxContainer/addCard/truthDare/truth.text
	var dare = $VBoxContainer/addCard/truthDare/dare.text
	if not truth.is_empty() and not dare.is_empty():
		cardsController.save("truth", {"gameMode": "truth", "content": truth, "deck": "custom"})
		cardsController.save("dare", {"gameMode": "dare", "content": dare, "deck": "custom"})
	_on_button_pressed(buttonPressed)
	$VBoxContainer/addCard/truthDare/truth.text = ""
	$VBoxContainer/addCard/truthDare/dare.text = ""

func removeCard(object):
	cardsController.removeCard(object.gameMode, object)
	if buttonPressed == "truth|dare":
		var tempArray = cards["truth"];
		tempArray += cards["dare"];
		displayCards(tempArray)
	else:
		displayCards(cards[buttonPressed])
