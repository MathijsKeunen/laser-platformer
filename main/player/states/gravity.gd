extends "motion.gd"

export var MaxMoveSpeed = 450
export var Acceleration = 25
export var Gravity = 1600
export var Decceleration = 10
export var MaxFallSpeed = 800

func enter(velocity = Vector2()):
	speed = velocity
	
	.enter(velocity)

func update(delta):
	
	speed.x = calculate_horizonatal_speed(speed.x)
	speed.y += delta*Gravity
	speed.y = min(speed.y, MaxFallSpeed)
	speed = owner.move_and_slide(speed,floor_normal)
	
	.update(delta)

func calculate_horizonatal_speed(horizontal_speed):
	
	var look_direction = get_horizontal_input_direction()
	update_look_direction(look_direction)
	
	if look_direction:
		horizontal_speed += Acceleration*look_direction
		horizontal_speed = clamp(horizontal_speed,-MaxMoveSpeed,MaxMoveSpeed)
	
	else:
		horizontal_speed -= Decceleration*sign(horizontal_speed)
	
	return horizontal_speed
