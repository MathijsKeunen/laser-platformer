extends Control

var current_scene_path = "res://levels/world1/level__selection.tscn"
var current_scene = load(current_scene_path).instance()
var scene_stack = []

func _ready():
	add_child(current_scene)
#	get_tree().set_current_scene(current_scene)

func _change_scene(path = "previous"):
	call_deferred("_deferred_change_scene", path)

func _deferred_change_scene(path):
	current_scene.free()
	if path == "previous":
		current_scene_path = scene_stack.pop_front()
	
	elif path == "restart":
		pass
	
	else:
		scene_stack.push_front(current_scene_path)
		current_scene_path = path
	
	current_scene = load(current_scene_path).instance()
	
	add_child(current_scene)
#	get_tree().set_current_scene(current_scene)
