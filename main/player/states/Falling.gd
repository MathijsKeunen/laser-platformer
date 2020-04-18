extends "gravity.gd"

func enter(velocity = Vector2()):
	owner.get_node("Sprite").play("Jumping")
	
	.enter(velocity)

func update(delta):
	.update(delta)
	floor_detection()
	
	if owner.collides_with_body_type("water"):
		emit_signal("finished", "Swimming", speed)

func floor_detection():
	
	if owner.is_on_floor():
		if owner.input_direction["up"] and owner.collides_with_area_type("ladder"):
			emit_signal("finished", "Climbing")
		
		elif owner.input_direction["down"]:
			emit_signal("finished", "Ducking")
		
		else:
			emit_signal("finished","Walking",speed)
