extends Area2D

signal entered(color)
signal exited(color)

export var color = "blue"

onready var sprite = $AnimatedSprite

# warning-ignore:unused_argument
func _on_flag_body_entered(body):
	sprite.play("waving")
	emit_signal("entered",color)

# warning-ignore:unused_argument
func _on_flag_body_exited(body):
	sprite.play("hanging")
	emit_signal("exited",color)

func _ready():
	sprite.set_sprite_frames(load("res://assets/environment items/flags/animations/" + color + ".tres"))
	sprite.play("hanging")
	
# warning-ignore:return_value_discarded
	owner.connect("collision_initialized",self,"_set_collision")
	connect("body_entered",self,"_on_flag_body_entered")
	connect("body_exited",self,"_on_flag_body_exited")

# warning-ignore:unused_argument
func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	set_collision_mask_bit(player_collision_bits_map[color], true)