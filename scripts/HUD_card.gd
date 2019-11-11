extends VBoxContainer

export var color = "blue"
export var key = "F1"

onready var texture_check = load("res://assets/HUD/player_heads/"+color+"_check.png")
onready var texture_no_check = load("res://assets/HUD/player_heads/"+color+"_no_check.png")

func _ready():
	$image.set_texture(texture_no_check)
	$key.set_text(key)