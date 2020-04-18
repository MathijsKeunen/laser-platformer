extends Node2D

onready var states_map = {
	"Walking": $Walking, 
	"Falling": $Falling,
	"Ducking": $Ducking, 
	"Climbing": $Climbing, 
	"Swimming": $Swimming,
	"Paused": $Paused,
	}

onready var current_state = states_map["Walking"]
onready var states_stack = [current_state]

func _unhandled_input(event):
	current_state.handle_input(event)

func switch_state(state_name, velocity = Vector2()):
	if state_name in ["Disabled", "Paused"]:
		states_stack.push_front(states_map[state_name])
		current_state = states_stack[0]
		current_state.enter(velocity)
	elif state_name == "previous":
		current_state.exit()
		states_stack.pop_front()
		current_state = states_map[0]
	else:
		current_state.exit()
		states_map[0] = states_map[state_name]
		current_state = states_map[state_name]
		current_state.enter(velocity)

func _physics_process(delta):
	current_state.update(delta)

func _ready():
	for child in get_children():
		child.connect("finished",self,"switch_state")
