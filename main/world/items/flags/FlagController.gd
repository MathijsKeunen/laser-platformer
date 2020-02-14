extends Node2D

###
#keeps track of which flags are reached by players of the right colors
###

#keeps track of the reached flags
var reached_flags = {}

signal all_flags_reached

func _ready():
	#initialise reached flags
	for flag in get_tree().get_nodes_in_group("flag"):
		reached_flags[flag.color] = false
	#signal emitted when all flags are reached
	connect("all_flags_reached",owner,"_on_all_flags_reached")

func _on_flag_entered(color):
	#called when a player enters a flag of the corresponding color
	#checks if all flags are reached
	reached_flags[color] = true
	if reached_flags.values().count(true) == reached_flags.values().size():
		emit_signal("all_flags_reached")

func _on_flag_exited(color):
	#called when a player exits a flag of the corresponding color
	reached_flags[color] = false
