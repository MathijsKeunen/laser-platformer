extends AnimatedSprite

func _ready():
	set_sprite_frames(load("res://player/animations/" + get_parent().color + ".tres"))
	play("Standing")