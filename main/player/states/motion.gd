extends "state.gd"

signal switch_input

var speed = Vector2()
var floor_normal = Vector2(0,-1)

func _ready():
	for switch in get_tree().get_nodes_in_group("switch"):
		connect("switch_input", switch, "_switch_input")

func get_input_direction():
	if owner.enabled:
		return int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

func update_look_direction(direction):
	
	if direction and owner.look_direction != direction:
		
		owner.get_node("Sprite").set_flip_h(false if direction == 1 else true)
		owner.look_direction = direction

func handle_input(event):
	
	if event.is_action_pressed("pull_switch"):
		var areas = owner.get_node("Area2D").get_overlapping_areas()
		for area in areas:
			if area.is_in_group("switch"):
				emit_signal("switch_input", area)
	
	if event.is_action_pressed("ui_up"):
		var areas = owner.get_node("Area2D").get_overlapping_areas()
		for area in areas:
			if area.is_in_group("ladder"):
				emit_signal("finished", "Climbing")
