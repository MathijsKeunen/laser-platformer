extends TileMap

func _ready():
	owner.connect("collision_initialized",self,"_set_collision")

func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	for bit in player_collision_bits_map.values():
		set_collision_layer_bit(bit, true)
