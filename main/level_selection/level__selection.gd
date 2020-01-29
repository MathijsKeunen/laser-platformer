extends Control

export var max_horizontal_levels = 8
export var max_vertical_levels = 4

export var world_folder = "res://levels/world1"
export var texture_path = "res://main/level_selection/grass.png"

func _ready():
	var levels = _list_levels()
	
	var containers = _add_containers(max_vertical_levels)
	_add_levels(levels, containers, max_horizontal_levels)

func _list_levels():
	
	var dir = Directory.new()
	dir.open(world_folder)
	dir.list_dir_begin(true)
	
	var files = []
	var file = dir.get_next()
	while file != "":
		files.append(world_folder + "/" + file)
		file = dir.get_next()
	
	files.sort_custom(self, "_sort_numerical")
	
	return files

func _add_containers(vertical):
	var children = []
	for i in range(vertical):
		var container = HBoxContainer.new()
#		container.set_v_size_flags(1)
		container.set_v_size_flags(3)
#		container.add_to_group("level_cards")
		children.append(container)
		add_child(container)
	
	return children

func _add_levels(levels, containers, horizontal):
	for i in range(len(levels)):
		var y = i/horizontal
		_add_card(levels[i], i + 1, containers[y])
	
	var remaining_space = horizontal - len(levels) % horizontal
	var margin = MarginContainer.new()
	margin.set_h_size_flags(3)
	margin.set_stretch_ratio(remaining_space)
	containers[len(levels)/horizontal].add_child(margin)

func _add_card(level, number, container):
	var card = load("res://main/level_selection/level_selection_card.tscn").instance()
	card.number = number
	card.texture_path = texture_path
	card.level = level
	container.add_child(card)

func _sort_numerical(a, b):
	return int(a.get_file()) < int(b.get_file())
