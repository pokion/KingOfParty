extends Node2D

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
	for card in cardsArray:
		var cardTemplateNew = cardTemplate.duplicate()
		cardTemplateNew.content = card.content
		$CanvasLayer/VBoxContainer/allCustomCards/ScrollContainer/cardContent.add_child(cardTemplateNew)

func _on_button_pressed(buttonName):
	utils.removeAllNodes($CanvasLayer/VBoxContainer/allCustomCards/ScrollContainer/cardContent)
	$CanvasLayer/VBoxContainer/buttons/HBoxContainer.find_child(buttonName).disabled = true;
	$CanvasLayer/VBoxContainer/buttons/HBoxContainer.find_child(buttonPressed).disabled = false;
	buttonPressed = buttonName;
	
	if buttonName != "truth|dare":
		if cards.has(buttonPressed):
			displayCards(cards[buttonPressed])
		$CanvasLayer/VBoxContainer/addCard/truthDare.visible = false;
		$CanvasLayer/VBoxContainer/addCard/addCard.visible = true;
	else:
		if cards.has("truth") and cards.has("dare"):
			var tempArray = cards["truth"];
			tempArray += cards["dare"];
			displayCards(tempArray)
		$CanvasLayer/VBoxContainer/addCard/truthDare.visible = true;
		$CanvasLayer/VBoxContainer/addCard/addCard.visible = false;
	buttonPressed = buttonName;

func save():
	var text = $CanvasLayer/VBoxContainer/addCard/addCard/LineEdit.text
	if not text.is_empty():
		cardsController.save(buttonPressed, {"gameMode": buttonPressed, "content": text, "deck": "custom"})
	_on_button_pressed(buttonPressed)
	
func saveTruthDare():
	var truth = $CanvasLayer/VBoxContainer/addCard/truthDare/truth.text
	var dare = $CanvasLayer/VBoxContainer/addCard/truthDare/dare.text
	if not truth.is_empty() and not dare.is_empty():
		cardsController.save("truth", {"gameMode": "truth", "content": truth, "deck": "custom"})
		cardsController.save("dare", {"gameMode": "dare", "content": dare, "deck": "custom"})
	_on_button_pressed(buttonPressed)
