extends KinematicBody2D

export var color = "blue"

var enabled
var look_direction = 1

func enter():
	enabled = true
	$state_machine.set_process_unhandled_input(true)
	$Camera2D.align()
	$Camera2D.make_current()

func exit():
	enabled = false
	$state_machine.set_process_unhandled_input(false)

func _ready():
# warning-ignore:return_value_discarded
	owner.connect("collision_initialized",self,"_set_collision")

func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	set_collision_layer_bit(player_collision_bits_map[color], true)
	set_collision_mask_bit(wall_collision_bits_map[color], true)
