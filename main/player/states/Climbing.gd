extends "motion.gd"

const VerticalClimbingSpeed = 200
const HorizontalClimbingSpeed = 200

func enter(speed = Vector2()):
	owner.get_node("Sprite").play("Climbing")

func update(delta):
	var ladder = owner.get_overlapping_ladder()
	if not ladder:
		emit_signal("finished", "Falling")
	
	else:
		var vertical_input_direction = get_vertical_input_direction()
		var horizontal_input_direction = get_horizontal_input_direction()
		
		speed.y = - vertical_input_direction * VerticalClimbingSpeed
		
		if ladder.top and speed.y < 0:
			speed.y = 0
		
		if speed.y == 0:
			owner.get_node("Sprite").stop()
		else:
			owner.get_node("Sprite").play()
		
		speed.x = horizontal_input_direction * HorizontalClimbingSpeed
		speed = owner.move_and_slide(speed,floor_normal,false,4,0.8)
	
	if owner.is_on_floor():
		if owner.input_direction["down"]:
			emit_signal("finished", "Ducking")
		else:
			emit_signal("finished", "Standing")
