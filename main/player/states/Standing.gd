extends "on_ground.gd"

func enter(velocity = Vector2()):
	print("standing")
	owner.get_node("Sprite").play("Standing")
	
	.enter(velocity)

func update(delta):
#	owner.move_and_slide(Vector2(),floor_normal)
	var look_direction = get_horizontal_input_direction()
	if look_direction:
		emit_signal("finished","Walking")
	
	.update(delta)
