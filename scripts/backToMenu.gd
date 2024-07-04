extends MarginContainer

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_mask == 1:
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
