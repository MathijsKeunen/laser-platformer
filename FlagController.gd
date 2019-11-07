extends Node2D

var reached_flags = {}

signal all_flags_reached

func _ready():
	for child in get_children():
		reached_flags[child.color] = false
		child.connect("entered",self,"_on_flag_entered")
		child.connect("exited",self,"_on_flag_exited")

func _on_flag_entered(color):
	reached_flags[color] = true
	if reached_flags.values().count(true) == reached_flags.values().size():
		emit_signal("all_flags_reached")
		print("all flags reached")

func _on_flag_exited(color):
	reached_flags[color] = false