extends Node2D

signal collision_initialized(player_collision_bits_map, wall_collision_bits_map)

var all_colors = []

var player_collision_bits_map = {}

var wall_collision_bits_map = {}

func _ready():
	for player in $player_controller.get_children():
		all_colors.append(player.color)
	
	for index in range(len(all_colors)):
		player_collision_bits_map[all_colors[index]] = index + 1
		wall_collision_bits_map[all_colors[index]] = len(all_colors) + index + 1
	
	emit_signal("collision_initialized",player_collision_bits_map,wall_collision_bits_map)

func _on_FlagController_all_flags_reached():
	pass # Replace with function body.
