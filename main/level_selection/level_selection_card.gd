extends Control

export(String) var texture_path
export(int) var number
export(NodePath) var level

func _ready():
	$block.set_texture(load(texture_path))
	$number/TextureRect.set_texture(load("res://main/level_selection/numbers/"+str(number)+".png"))

func _on_level_selection_card_gui_input(event):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		print(level)
		get_tree().change_scene(level)