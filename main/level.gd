extends Node2D

signal collision_initialized(player_collision_bits_map, wall_collision_bits_map)
signal level_exited

var all_colors = []
var player_collision_bits_map = {}
var wall_collision_bits_map = {}

func _ready():
	for player in $player_controller.get_children():
		all_colors.append(player.color)
	
	for laser in $world/lasers.get_children():
		if not laser.color in all_colors:
			all_colors.append(laser.color)
	
	for index in range(len(all_colors)):
		player_collision_bits_map[all_colors[index]] = index + 1
		wall_collision_bits_map[all_colors[index]] = len(all_colors) + index + 1
	
	emit_signal("collision_initialized",player_collision_bits_map,wall_collision_bits_map)
	
	connect("level_exited", get_tree().get_root().get_child(0), "_change_scene")

func _on_all_flags_reached():
	print("all flags reached")

func _exit_level():
	emit_signal("level_exited", "previous")
