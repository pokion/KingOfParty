extends Node

static func centerNode(node: Node2D) -> void:
	node.position = DisplayServer.window_get_size()/2

static func showNodes(nodes: Array) -> void:
	for node in nodes:
		node.visible = true;

static func hideNodes(nodes: Array) -> void:
	for node in nodes:
		node.visible = false;
		
static func removeAllNodes(node: Node) -> void:
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()
