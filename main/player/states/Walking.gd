extends "on_ground.gd"

export var MaxWalkSpeed = 450
export var Acceleration = 50

func enter(velocity = Vector2()):
	
	speed.x = velocity.x
	speed.y = 0
	
	if speed.x == 0:
		owner.get_node("Sprite").play("Standing")
	else:
		owner.get_node("Sprite").play("Walking")
	
	.enter(velocity)

func update(delta):
	
	var look_direction = get_horizontal_input_direction()
	update_look_direction(look_direction)
	
	if not look_direction:
		speed.x = 0
		owner.get_node("Sprite").play("Standing")
	
	else:
		owner.get_node("Sprite").play("Walking")
		speed.x += Acceleration*look_direction
		speed.x = clamp(speed.x, -MaxWalkSpeed, MaxWalkSpeed)
	
	speed = owner.move_and_slide_with_snap(speed,Vector2(0,1),floor_normal,false,4,0.8)
	
	if owner.input_direction["down"]:
		emit_signal("finished", "Ducking")
	
	.update(delta)
