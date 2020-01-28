extends Control

export var max_horizontal_levels = 8
export var max_vertical_levels = 4

export var world_folder = "res://levels/world1"
export var texture_path = "res://main/level_selection/grass.png"

var levels

func _ready():
	levels = _list_levels()

	_add_levels(max_horizontal_levels,max_vertical_levels, levels)

func _list_levels():
	
	var dir = Directory.new()
	dir.open(world_folder)
	dir.list_dir_begin(true)
	
	var files = []
	var file = dir.get_next()
	while file != "":
		files.append(world_folder + "/" + file)
		file = dir.get_next()
	
	return files

func _add_levels(horizontal, vertical, levels):
	for i in range(vertical):
		var container = HBoxContainer.new()
		container.set_v_size_flags(1)
		container.set_v_size_flags(2)
		container.add_to_group("level_cards")
		add_child(container)
	
	var children = get_children()
	print(children)
	for i in range(len(levels)):
		var card = load("res://main/level_selection/level_selection_card.tscn").instance()
		card.number = i + 1
		card.texture_path = texture_path
		card.level = levels[i]
		
		var y = i/horizontal + 1
#		var x = i%8
		
		children[y].add_child(card)
