extends "on_ground.gd"

export var MaxWalkSpeed = 200
export var Acceleration = 50

func enter(velocity = Vector2()):
	owner.get_node("CollisionShapeStanding").set_disabled(true)
	speed.x = velocity.x
	speed.y = 0
	
	owner.get_node("Sprite").play("Ducking")
	
	.enter(velocity)

func update(delta):
	
	var look_direction = get_horizontal_input_direction()
	update_look_direction(look_direction)
	
	if (not owner.enabled or not Input.is_action_pressed("ui_down"))\
	 and not owner.test_move(owner.get_transform(), Vector2(0, -23.939)):
		if speed.x == 0:
			emit_signal("finished","Standing")
		
		else:
			emit_signal("finished","Walking",speed)
	
	elif not look_direction:
		
		speed.x = 0
		
	else:
		
		speed.x += Acceleration*look_direction
		speed.x = clamp(speed.x,-MaxWalkSpeed,MaxWalkSpeed)
		speed = owner.move_and_slide_with_snap(speed,Vector2(0,1),floor_normal,false,4,0.8)
	
	.update(delta)

func exit():
	owner.get_node("CollisionShapeStanding").set_disabled(false)
	
	owner.input_direction["down"] = false
	.exit()
