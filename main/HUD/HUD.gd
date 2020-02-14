extends CanvasLayer

var color_map = {}

func _on_player_controller_players_ready(action_player_map):
	for action in action_player_map:
		var child = load("res://main/HUD/HUD_card.tscn").instance()
		var color = action_player_map[action].color
		color_map[color] = child
		child.color = color
		var key = InputMap.get_action_list(action)
		child.key = key[0].as_text()
		$Margin/HBoxContainer.add_child(child)

func activate_check_mark(color):
	var child = color_map[color]
	child.get_node("image").set_texture(child.texture_check)

func deactivate_check_mark(color):
	var child = color_map[color]
	child.get_node("image").set_texture(child.texture_no_check)
