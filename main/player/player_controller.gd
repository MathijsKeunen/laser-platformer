extends Node2D

###
#configures the players and the corresponding actions to switch between them
#handles switching between players
#handles pausing the game
###

#the default player for when the level is started
export(NodePath) var start_player

var current_player
var current_color
var action_player_map = {}

signal players_ready(key_player_map)
signal start_switch_animation(current_position,new_position)

func _ready():
	
	var all_players = get_tree().get_nodes_in_group("player")
	_map_actions(all_players)
	_configure_players(all_players)
	
	#signal to start the camera animation when switching players
	connect("start_switch_animation",get_node("../drone"),"_on_start_camera_animation")
	#signal to add the player heads to the HUD
	connect("players_ready",get_node("../HUD"),"_on_player_controller_players_ready")
	
	emit_signal("players_ready",action_player_map)

func _map_actions(all_players):
	#connects the switch_player actions to the right players
	for action_number in range(1, len(all_players) + 1):
		action_player_map["switch_player_" + str(action_number)] = all_players[action_number - 1]

func _configure_players(all_players):
	#configures all players in their initial state
	for player in all_players:
		player.exit()
	
	current_player = get_node(start_player)
	current_color = current_player.color
	current_player.enter()

func _unhandled_input(event):
	#handles switch_player actions
	if event.is_action_type() and event.is_pressed():
		for action in action_player_map:
			if event.is_action(action):
				var new_player = action_player_map[action]
				if current_player != new_player:
					switch_color(new_player)

func switch_color(new_player):
	#starts transition to new player
	#sends a signal to the drone to start the camera animation
	var old_player = current_player
	current_player = new_player
	var current_position = old_player.get_node("Camera2D").get_camera_position()
	var new_position = new_player.get_position()
	emit_signal("start_switch_animation",current_position,new_position)
	
	old_player.exit()
	current_color = new_player.color
	yield(get_node("../drone").get_node("Tween"), "tween_all_completed")
	new_player.enter()

func _pause(pause):
	#called when the pause menu is entered or exited
	#pause menu is entered if variable pause is true, exited if false
	#pauses the current player and freezes him into place
	for player in get_children():
		player.get_node("state_machine").switch_state("Paused" if pause else "previous")
