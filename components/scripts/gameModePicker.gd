extends Control

signal onGameModeToggle(isTrue, gameMode)

func _on_toggled(button_pressed, gameMode):
	onGameModeToggle.emit(button_pressed, gameMode)
