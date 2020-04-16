extends Camera2D

export var animation_time = 0.2

func _on_start_camera_animation(current_position, new_position):
	var tween = get_node("Tween")
	tween.interpolate_property(self, "position",
		current_position, new_position, animation_time,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(get_node("Tween"), "tween_started")
	make_current()
