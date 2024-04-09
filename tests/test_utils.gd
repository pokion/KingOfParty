extends GutTest

var Utils = load("res://scripts/utils.gd");
var arrayOfNodes = []

func before_each():
	arrayOfNodes = []
	for n in range(8):
		var newNode = double(Node2D).new();
		if n % 2 == 1:
			newNode.visible = true;
		else:
			newNode.visible = false;
		arrayOfNodes.append(newNode);

func test_centerNode():
	var centerOfDisplay = DisplayServer.window_get_size()/2 as Vector2;
	var sampleNode = double(Node2D).new();
	sampleNode.position = Vector2(202,303)
	Utils.centerNode(sampleNode)
	assert_eq(sampleNode.position, centerOfDisplay, "Node have a different position than center.")

func test_showNodes():
	var arrayNodesDuplicated = arrayOfNodes.duplicate();
	Utils.showNodes(arrayNodesDuplicated);
	for node in arrayNodesDuplicated:
		assert_eq(node.visible, true, "All nodes should have visible set to true.");
		
func test_hideNodes():
	var arrayNodesDuplicated = arrayOfNodes.duplicate();
	Utils.hideNodes(arrayNodesDuplicated);
	for node in arrayNodesDuplicated:
		assert_eq(node.visible, false, "All nodes should have visible set to false.");
