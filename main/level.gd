extends Node2D

###
#manages the collision bits for every element in the level that requires it
#handles exiting or restarting the level
###

signal level_exited

signal collision_initialized(player_collision_bits_map, wall_collision_bits_map)

func _ready():
	#initialise all the colors present in the level and map them to the correct 
	#collision bits
	var all_colors = get_all_colors()
	var player_collision_bits_map = map_player_collision_bits(all_colors)
	var wall_collision_bits_map = map_wall_collision_bits(all_colors)
	
	#signal to set the collision bits on players and items such as switches
	#and lasers
	emit_signal("collision_initialized",player_collision_bits_map,wall_collision_bits_map)
	
	#signal for exiting and restarting the level
	connect("level_exited", get_tree().get_root().get_child(0), "_change_scene")

func get_all_colors():
	#list the colors of all the players
	var all_colors = []
	for player in get_tree().get_nodes_in_group("player"):
		all_colors.append(player.color)
	
	return all_colors

func map_player_collision_bits(all_colors):
	#determine the collision bits for players of each color
	var player_collision_bits_map = {}
	for index in range(len(all_colors)):
		player_collision_bits_map[all_colors[index]] = index + 1
	
	return player_collision_bits_map

func map_wall_collision_bits(all_colors):
	#determine the collision bits for obstacles (such as lasers) of each color
	var wall_collision_bits_map = {}
	for index in range(len(all_colors)):
		wall_collision_bits_map[all_colors[index]] = len(all_colors) + index + 1
	
	return wall_collision_bits_map

func _on_all_flags_reached():
	#called when every flag in the level is reached by a player of the right
	#color
	#todo: add screen indicating the level is finished
	#might include:
	#	-total time the level was finished in
	#	-button to go back to the level selection menu
	#	-button to go to the next level
	print("all flags reached")

func _exit_level():
	#called when the exit in the pause menu is clicked
	emit_signal("level_exited", "previous")

func _restart_level():
	#called when the restart level button in the pause menu is clicked
	emit_signal("level_exited", "restart")
