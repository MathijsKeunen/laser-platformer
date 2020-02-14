extends Control

signal level_selected

export(String) var texture_path
export(int) var number
export(NodePath) var level

func _ready():
	$block.set_texture(load(texture_path))
	_set_number_texture(number)
	
	connect("level_selected",get_tree().get_root().get_child(0), "_change_scene")

func _set_number_texture(i):
	var numbers = _get_numbers(i)
	
	for i in numbers:
		var texture = TextureRect.new()
		texture.set_texture(load("res://main/level_selection/numbers/"+str(i)+".png"))
		texture.set_v_size_flags(4)
		$number.add_child(texture)

func _on_level_selection_card_gui_input(event):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("level_selected", level)

func _get_numbers(i):
	var numbers = []
	while i != 0:
		numbers.push_front(i % 10)
		i /= 10
	
	return numbers
