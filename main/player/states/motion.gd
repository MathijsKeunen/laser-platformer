extends "state.gd"

# warning-ignore:unused_class_variable
var speed = Vector2()
# warning-ignore:unused_class_variable
var floor_normal = Vector2(0,-1)

func get_input_direction():
	if owner.enabled:
		return int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

func update_look_direction(direction):
	
	if direction and owner.look_direction != direction:
		
		owner.get_node("Sprite").set_flip_h(false if direction == 1 else true)
		owner.look_direction = direction