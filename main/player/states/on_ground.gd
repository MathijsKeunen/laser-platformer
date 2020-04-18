extends "motion.gd"

export var JumpSpeed = 800

func handle_input(event):
	if event.is_action_pressed("ui_up") and not owner.collides_with_area_type("ladder"):
		emit_signal("finished", "Falling", Vector2(speed.x, -JumpSpeed))
	
	.handle_input(event)

func update(delta):
	if owner.input_direction["up"] and owner.collides_with_area_type("ladder"):
		emit_signal("finished", "Climbing")
	
	elif not owner.is_on_floor():
		
		emit_signal("finished","Falling",Vector2(speed.x,0))
	
	elif owner.collides_with_body_type("water"):
		emit_signal("finished", "Swimming", speed)
	
	.update(delta)
