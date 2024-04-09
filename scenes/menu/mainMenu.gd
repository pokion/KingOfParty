extends Node2D

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/gameSetup/gameSetup.tscn")

func _on_author_pressed():
	get_tree().change_scene_to_file("res://scenes/credicts.tscn")
