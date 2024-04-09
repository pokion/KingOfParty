extends Control

signal sendSelected(gameTypeName)

func _on_panel_gui_input(event, extra_arg_0):
	if event is InputEventMouseButton and event.pressed:
		if extra_arg_0 == "pass":
			$CenterContainer/HBoxContainer/passPhone/Panel/Label.visible = true
			$CenterContainer/HBoxContainer/onePlayerHold/Panel/Label.visible = false
		else:
			$CenterContainer/HBoxContainer/passPhone/Panel/Label.visible = false
			$CenterContainer/HBoxContainer/onePlayerHold/Panel/Label.visible = true
		sendSelected.emit(extra_arg_0)
