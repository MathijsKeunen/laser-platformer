extends CanvasLayer

var color_map = {}

func _on_player_controller_players_ready(key_player_map):
	for key in key_player_map:
		var child = load("res://main/HUD/HUD_card.tscn").instance()
		var color = key_player_map[key].color
		color_map[color] = child
		child.color = color
		child.key = key
		$Margin/HBoxContainer.add_child(child)

func activate_check_mark(color):
	var child = color_map[color]
	child.get_node("image").set_texture(child.texture_check)

func deactivate_check_mark(color):
	var child = color_map[color]
	child.get_node("image").set_texture(child.texture_no_check)
