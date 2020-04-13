extends Area2D

export var top = false

func _ready():
	owner.connect("collision_initialized",self,"_set_collision")
	if top:
		$Sprite.set_texture(load("res://main/world/items/ladder/ladder_top.png"))

func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	for bit in player_collision_bits_map.values():
		set_collision_layer_bit(bit, true)
#	set_collision_layer_bit(10, true)
