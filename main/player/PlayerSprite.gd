extends AnimatedSprite

func _ready():
	set_sprite_frames(load("res://main/player/sprites/animations/" + get_parent().color + ".tres"))
	play("Standing")