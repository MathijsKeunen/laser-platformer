extends "res://main/player/states/state.gd"

func enter(velocity = Vector2()):
	owner.get_node("Sprite").stop()

func exit():
	owner.get_node("Sprite").play()
	owner.reset_input_directions()
