extends "motion.gd"

func handle_input(event):
	if event.is_action_pressed("ui_up"):
		emit_signal("finished","Jumping",speed)
	
	if event.is_action_pressed("ui_down"):
		emit_signal("finished","Ducking",speed)
	
	.handle_input(event)

func update(delta):
	if not owner.is_on_floor():
		
		emit_signal("finished","Falling",Vector2(speed.x,0))
	
	.update(delta)