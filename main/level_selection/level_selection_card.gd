extends Control

export(String) var texture_path
export(int) var number
export(NodePath) var level

func _ready():
	$block.set_texture(load(texture_path))
	_set_number_texture(number)

func _set_number_texture(number):
	var numbers = _get_numbers(number)
	
	for i in numbers:
		var texture = TextureRect.new()
		texture.set_texture(load("res://main/level_selection/numbers/"+str(i)+".png"))
		texture.set_v_size_flags(4)
		$number.add_child(texture)

func _on_level_selection_card_gui_input(event):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		print(level)
		get_tree().change_scene(level)

func _get_numbers(number):
	var numbers = []
	while number != 0:
		numbers.push_front(number % 10)
		number /= 10
	
	return numbers
