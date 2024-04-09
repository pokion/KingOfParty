extends Control

signal colorPickedPropagate(color)

func _on_test_panel_color_picked(color):
	colorPickedPropagate.emit(color)
