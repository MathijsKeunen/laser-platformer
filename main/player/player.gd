extends KinematicBody2D

###
#contains basic information about the player
#handles (de)activating the player
###

export var color = "blue"

var enabled
var look_direction = 1

func enter():
	#activates the player
	enabled = true
	$state_machine.set_process_unhandled_input(true)
	$Camera2D.align()
	$Camera2D.make_current()

func exit():
	#deactivates the player
	enabled = false
	$state_machine.set_process_unhandled_input(false)

func _ready():
	#signal to configure collision
	owner.connect("collision_initialized",self,"_set_collision")

func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	#sets collision of the player
	set_collision_layer_bit(player_collision_bits_map[color], true)
	set_collision_mask_bit(wall_collision_bits_map[color], true)
	$Area2D.set_collision_mask_bit(player_collision_bits_map[color], true)
