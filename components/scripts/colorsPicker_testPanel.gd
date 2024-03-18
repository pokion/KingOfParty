extends Panel

signal colorPicked(color)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		colorPicked.emit(self.get_theme_stylebox("panel").bg_color)
