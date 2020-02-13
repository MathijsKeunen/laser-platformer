extends "motion.gd"

export var MaxMoveSpeed = 450
export var Acceleration = 25
export var Gravity = 1600
export var Decceleration = 10

func enter(velocity = Vector2()):
	speed.x = velocity.x
	owner.get_node("Sprite").play("Jumping")
	
	.enter(velocity)

func update(delta):
	
	speed.x = calculate_horizonatal_speed(speed.x)
	speed.y += delta*Gravity
	speed = owner.move_and_slide(speed,floor_normal)
	
	floor_detection()
	
	.update(delta)

# warning-ignore:unused_argument
func calculate_horizonatal_speed(horizontal_speed):
	
	var look_direction = get_input_direction()
	update_look_direction(look_direction)
	
	if look_direction:
		horizontal_speed += Acceleration*look_direction
		horizontal_speed = clamp(horizontal_speed,-MaxMoveSpeed,MaxMoveSpeed)
	
	else:
		horizontal_speed -= Decceleration*sign(horizontal_speed)
	
	return horizontal_speed

func floor_detection():
	
	if owner.is_on_floor():
		if speed.x == 0:
			emit_signal("finished","Standing")
		
		else:
			emit_signal("finished","Walking",speed)
