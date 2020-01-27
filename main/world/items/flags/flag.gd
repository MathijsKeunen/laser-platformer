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
	sprite.set_sprite_frames(load("res://main/world/items/flags/sprites/animations/" + color + ".tres"))
	sprite.play("hanging")
	
# warning-ignore:return_value_discarded
	connect("body_entered",self,"_on_flag_body_entered")
# warning-ignore:return_value_discarded
	connect("body_exited",self,"_on_flag_body_exited")
# warning-ignore:return_value_discarded
	connect("entered",$"..","_on_flag_entered")
# warning-ignore:return_value_discarded
	connect("exited",$"..","_on_flag_exited")
	
# warning-ignore:return_value_discarded
	connect("entered",get_node("/root/level/HUD"),"activate_check_mark")
# warning-ignore:return_value_discarded
	connect("exited",get_node("/root/level/HUD"),"deactivate_check_mark")
	
# warning-ignore:return_value_discarded
	owner.connect("collision_initialized",self,"_set_collision")

# warning-ignore:unused_argument
func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	set_collision_mask_bit(player_collision_bits_map[color], true)