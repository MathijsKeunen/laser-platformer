extends Node2D

export(NodePath) var start_player

onready var all_players = get_children()

var current_player
var current_color
var key_player_map = {}

signal players_ready(key_player_map)
signal start_switch_animation(current_position,new_position)

func _ready():
	for key_number in range(1,len(all_players)+1):
		key_player_map["F"+str(key_number)] = all_players[key_number-1]

	for player in all_players:
		player.exit()
	
	current_player = get_node(start_player)
	current_color = current_player.color
	current_player.enter()
	
# warning-ignore:return_value_discarded
	connect("start_switch_animation",get_node("../drone"),"_on_start_camera_animation")
# warning-ignore:return_value_discarded
	connect("players_ready",get_node("../HUD"),"_on_player_controller_players_ready")
	
	emit_signal("players_ready",key_player_map)

func _unhandled_input(event):
	
	if event.is_pressed():
		var key = event.as_text()
		if key in key_player_map.keys():
			
			var new_player = key_player_map[key]
			if current_player != new_player:
				switch_color(new_player)

func switch_color(new_player):
	
	var current_position = current_player.get_node("Camera2D").get_camera_position()
	var new_position = new_player.get_position()
	
	current_player.exit()
	emit_signal("start_switch_animation",current_position,new_position)
	
	current_player = new_player
	current_color = current_player.color

func _on_drone_finish_camera_animation():
	current_player.enter()
