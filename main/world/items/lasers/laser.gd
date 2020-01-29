extends TileMap

export var color = "blue"
export var active_on_start = true

var collision_layer_when_active = 0

func _ready():
	set_tileset(load("res://main/world/items/lasers/sprites/tilesets/"+color+".tres"))
# warning-ignore:return_value_discarded
	owner.connect("collision_initialized",self,"_set_collision")

# warning-ignore:unused_argument
func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	
	for bit in wall_collision_bits_map.values():
		collision_layer_when_active += pow(2,bit)
	
	collision_layer_when_active -= pow(2,wall_collision_bits_map[color])
	_set_active(active_on_start)

func _set_active(active):
	set_collision_layer(collision_layer_when_active if active else 0)
	set_visible(active)
