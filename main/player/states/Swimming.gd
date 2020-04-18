extends "gravity.gd"

export var SwimUpAcceleration = 300
export var MaxSwimUpSpeed = 700

func enter(velocity = Vector2()):
	owner.get_node("Sprite").play("Swimming")
	.enter(velocity)

func handle_input(event):
	if event.is_action_pressed("ui_up"):
		speed.y -= SwimUpAcceleration
		speed.y = max(speed.y, -MaxSwimUpSpeed)
	.handle_input(event)

func update(delta):
	if not owner.collides_with_body_type("water"):
		emit_signal("finished", "Falling", speed)
	.update(delta)
