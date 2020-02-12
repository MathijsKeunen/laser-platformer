extends Control

export var max_horizontal_levels = 8
export var max_vertical_levels = 4

export var world_folder = "res://levels/world1"
export var texture_path = "res://levels/world1/grass.png"

func _ready():
	var levels = _list_levels()
	
	var containers = _add_containers(max_vertical_levels)
	_add_levels(levels, containers, max_horizontal_levels)

func _list_levels():

	var dir = Directory.new()
	dir.open(world_folder)
	
	var levels = []
	var i = 1
	var level = world_folder + "/1.tscn"
	while dir.file_exists(level):
		levels.append(level)
		i += 1
		level = world_folder +"/" + str(i) + ".tscn"
	
	return levels

func _add_containers(vertical):
	var children = []
	for i in range(vertical):
		var container = HBoxContainer.new()
		container.set_v_size_flags(3)
		container.set("custom_constants/separation", 20)
		children.append(container)
		add_child(container)
	
	return children

func _add_levels(levels, containers, horizontal):
	for i in range(len(levels)):
		var y = i/horizontal
		_add_card(levels[i], i + 1, containers[y])
	
	for i in range(horizontal - len(levels) % horizontal):
		var margin = Control.new()
		margin.set_h_size_flags(3)
		containers[len(levels)/horizontal].add_child(margin)

func _add_card(level, number, container):
	var card = load("res://main/level_selection/level_selection_card.tscn").instance()
	card.number = number
	card.texture_path = texture_path
	card.level = level
	container.add_child(card)
