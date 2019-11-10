extends VBoxContainer

export var color = "blue"
export var key = "F1"

func _ready():
	$image.set_texture(load("res://assets/HUD/player_heads/"+color+".png"))
	$key.set_text(key)