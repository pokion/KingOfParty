extends Control
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/gameSetup/gameSetup.tscn")

func _on_author_pressed():
	get_tree().change_scene_to_file("res://scenes/credicts.tscn")

func _on_custom_cards_pressed():
	get_tree().change_scene_to_file("res://scenes/customCards/customCards.tscn")
