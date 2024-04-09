extends Panel

signal colorPicked(color)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		colorPicked.emit(self.get_theme_stylebox("panel").bg_color)
