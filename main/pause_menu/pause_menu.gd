extends CanvasLayer

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause_menu()

func _toggle_pause_menu():
	$HBoxContainer.set_visible(!$HBoxContainer.is_visible())

func _on_close_pressed():
	get_tree().quit()
