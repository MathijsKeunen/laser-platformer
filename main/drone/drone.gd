extends Tween

export var animation_time = 0.2

func _on_start_camera_animation(current_position, new_position):
	interpolate_property($Camera2D, "position",
		current_position, new_position, animation_time,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	start()
	yield(self, "tween_started")
	$Camera2D.make_current()
