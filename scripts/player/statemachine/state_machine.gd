extends Node2D

onready var states_map = {
	"Standing": $Standing, 
	"Walking": $Walking, 
	"Jumping": $Jumping,
	"Falling": $Falling,
	"Ducking": $Ducking, 
	"Climbing": $Climbing, 
	"Swimming": $Swimming
	}

onready var current_state = states_map["Standing"]

func _unhandled_input(event):
	current_state.handle_input(event)

func switch_state(state_name, velocity = Vector2()):
	
	current_state.exit()
	current_state = states_map[state_name]
	current_state.enter(velocity)

func _physics_process(delta):
	current_state.update(delta)

func _ready():
	for child in get_children():
		child.connect("finished",self,"switch_state")