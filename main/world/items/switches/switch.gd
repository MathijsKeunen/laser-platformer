extends Area2D

###
#initializes the switch
#handles pulling the switch
#contains basic information about the switch
###

export var color = "blue"
export var active = true

signal switched(active)
signal switched_inversed(active)

func _ready():
	#initializes the switch
	$AnimatedSprite.set_sprite_frames(load("res://main/world/items/switches/sprites/animations/"+color+".tres"))
	$AnimatedSprite.play("on" if active else "off")
	add_to_group(color)
	#signal to configure collision
	owner.connect("collision_initialized",self,"_set_collision")

func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	#sets collision of the switch
	set_collision_mask_bit(player_collision_bits_map[color], true)

func _switch_input(player):
	#called when a player tries to pull a switch
	#checks if the player is in reach of the switch and if the color matches
	if overlaps_body(player) and player.color == color:
		switch()

func switch():
	#changes the state of the switch between active and not active
	#emits signal to connected lasers
	active = !active
	$AnimatedSprite.play("on" if active else "off")
	emit_signal("switched", active)
	emit_signal("switched_inversed", !active)
