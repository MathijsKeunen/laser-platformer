extends "state.gd"

signal switch_input

var speed = Vector2()
var floor_normal = Vector2(0,-1)

func _ready():
	for switch in get_tree().get_nodes_in_group("switch"):
		connect("switch_input", switch, "_switch_input")

func get_horizontal_input_direction():
	return int(owner.input_direction["right"]) - int(owner.input_direction["left"])

func get_vertical_input_direction():
	return int(owner.input_direction["down"]) - int(owner.input_direction["up"])

func update_look_direction(direction):
	
	if direction and owner.look_direction != direction:
		
		owner.get_node("Sprite").set_flip_h(false if direction == 1 else true)
		owner.look_direction = direction

func handle_input(event):
	if event.is_action("ui_left"):
		owner.input_direction["left"] = event.is_pressed()
	
	elif event.is_action("ui_right"):
		owner.input_direction["right"] = event.is_pressed()
	
	if event.is_action("ui_up"):
		owner.input_direction["up"] = event.is_pressed()
	
	elif event.is_action("ui_down"):
		owner.input_direction["down"] = event.is_pressed()
	
	if event.is_action_pressed("pull_switch"):
		var areas = owner.get_node("BodyArea").get_overlapping_areas()
		for area in areas:
			if area.is_in_group("switch"):
				emit_signal("switch_input", area)

#func update(delta):
#	if speed.y != 0:
#		owner.get_node("Label").set_text(str(speed.y))
#	.update(delta)
