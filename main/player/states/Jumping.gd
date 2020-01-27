extends "Falling.gd"

export var JumpSpeed = 800

# warning-ignore:unused_argument
func enter(velocity = Vector2()):
	speed.y = -JumpSpeed
	
	.enter()