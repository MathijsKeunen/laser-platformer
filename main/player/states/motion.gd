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
	if event.is_action_pressed("ui_select"):
		emit_signal("switch_input", owner)
