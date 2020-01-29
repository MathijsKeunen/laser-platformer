extends Node2D

export var animation_time = 0.2

var camera_position
var start_position
var end_position
var elapsed_time

signal finish_camera_animation

func _ready():
	set_process(false)
# warning-ignore:return_value_discarded
	connect("finish_camera_animation",get_node("../player_controller"),"_on_drone_finish_camera_animation")

func _process(delta):
	if elapsed_time >= animation_time:
		emit_signal("finish_camera_animation")
		set_process(false)
		
	else:
		elapsed_time += delta
		camera_position = start_position.linear_interpolate(end_position,elapsed_time/animation_time)
		set_position(camera_position)

func _on_start_camera_animation(current_position, new_position):
	set_position(current_position)
	start_position = current_position
	end_position = new_position
	elapsed_time = 0
	$Camera2D.align()
	$Camera2D.make_current()
	set_process(true)
