extends KinematicBody2D

###
#contains basic information about the player
#handles (de)activating the player
###

export var color = "blue"

var enabled
var look_direction = 1
var input_direction = {
	"left": false,
	"right": false,
	"down": false,
	"up": false
	}

func enter():
	#activates the player
	enabled = true
	input_direction["left"] = Input.is_action_pressed("ui_left")
	input_direction["right"] = Input.is_action_pressed("ui_right")
	input_direction["up"] = Input.is_action_pressed("ui_up")
	input_direction["down"] = Input.is_action_pressed("ui_down")
	$Sprite.play()
	$state_machine.set_process_unhandled_input(true)
	$Camera2D.align()
	$Camera2D.make_current()

func exit():
	#deactivates the player
	enabled = false
	input_direction["left"] = false
	input_direction["right"] = false
	input_direction["down"] = false
	input_direction["up"] = false
	$state_machine.set_process_unhandled_input(false)
	$Sprite.stop()

func _ready():
	#signal to configure collision
	owner.connect("collision_initialized",self,"_set_collision")

func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	#sets collision of the player
	set_collision_layer_bit(player_collision_bits_map[color], true)
	set_collision_mask_bit(wall_collision_bits_map[color], true)
	$BodyArea.set_collision_mask_bit(player_collision_bits_map[color], true)
	$HeadArea.set_collision_mask_bit(player_collision_bits_map[color], true)

func collides_with_area_type(type, head_area = false):
	var collision_area = $BodyArea if not head_area else $HeadArea
	var areas = collision_area.get_overlapping_areas()
	for area in areas:
		if area.is_in_group(type):
			return true
	return false
