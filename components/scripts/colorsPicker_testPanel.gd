extends Panel

signal colorPicked(color)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		print(event)
		colorPicked.emit(self.get_theme_stylebox("panel").bg_color)
