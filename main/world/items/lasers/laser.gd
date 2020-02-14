extends TileMap

###
#initializes the laser
#handles activation en deactivation of the laser
#contains basic information about the laser
###

export var color = "blue"
export var active_on_start = true

var collision_layer_when_active = 0

func _ready():
	#configures the color of the laser
	set_tileset(load("res://main/world/items/lasers/sprites/tilesets/"+color+".tres"))
	#signal to configure collision
	owner.connect("collision_initialized",self,"_set_collision")

func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	#sets collision of the laser
	#activates or deactivates laser corresponding activate_on_start
	for bit in wall_collision_bits_map.values():
		collision_layer_when_active += pow(2,bit)
	
	if color in wall_collision_bits_map:
		collision_layer_when_active -= pow(2,wall_collision_bits_map[color])
	
	_set_active(active_on_start)

func _set_active(active):
	#called when the switch this laser is connected to is (de)activated
	set_collision_layer(collision_layer_when_active if active else 0)
	set_visible(active)
