extends CanvasLayer

signal paused

func _ready():
	connect("paused", owner.get_node("player_controller"), "_pause")

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause_menu()

func _toggle_pause_menu():
	var paused = !$HBoxContainer.is_visible()
	emit_signal("paused", paused)
	$HBoxContainer.set_visible(paused)
