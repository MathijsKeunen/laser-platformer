extends VBoxContainer

export var color = "blue"
export var key = "F1"

# warning-ignore:unused_class_variable
onready var texture_check = load("res://main/HUD/player_heads/"+color+"_check.png")
onready var texture_no_check = load("res://main/HUD/player_heads/"+color+"_no_check.png")

func _ready():
	$image.set_texture(texture_no_check)
	$key.set_text(key)
