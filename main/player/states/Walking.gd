extends "on_ground.gd"

export var MaxWalkSpeed = 450
export var Acceleration = 50

func enter(velocity = Vector2()):
	
	speed.x = velocity.x
	speed.y = 0
	
	owner.get_node("Sprite").play("Walking")
	
	.enter(velocity)

func update(delta):
	
	var look_direction = get_horizontal_input_direction()
	update_look_direction(look_direction)
	
	if not look_direction:
		emit_signal("finished","Standing")
		
	else:
		
		if speed.x*look_direction < MaxWalkSpeed:
			speed.x += Acceleration*look_direction
		
		else:
			speed.x = MaxWalkSpeed*look_direction

		speed = owner.move_and_slide_with_snap(speed,Vector2(0,1),floor_normal,false,4,0.8)
	
	.update(delta)
