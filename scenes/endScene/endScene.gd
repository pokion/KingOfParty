extends Control

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn");

func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://scenes/gameSetup/gameSetup.tscn")
