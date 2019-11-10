extends CanvasLayer


func _on_player_controller_players_ready(key_player_map):
	for key in key_player_map:
		var child = load("res://scenes/HUD_card.tscn").instance()
		child.color = key_player_map[key].color
		child.key = key
		$Margin/HBoxContainer.add_child(child)