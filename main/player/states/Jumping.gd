extends "Falling.gd"

export var JumpSpeed = 800

func enter(velocity = Vector2()):
	speed.y = -JumpSpeed
	velocity.y = -JumpSpeed
	print("jumping")
	.enter(velocity)
