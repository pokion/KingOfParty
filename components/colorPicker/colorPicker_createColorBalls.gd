extends FlowContainer

func _ready():
	var allColors = get_node("/root/Players").getAllColors();
	var testPanel = $testPanel
	for color in allColors:
		var newPanel = testPanel.duplicate();
		changeColor(color, newPanel)
		newPanel.visible = true
		add_child(newPanel);

func changeColor(color: Color, panel):
	var style = panel.get_theme_stylebox("panel").duplicate()
	style.bg_color = color
	panel.add_theme_stylebox_override("panel", style)
