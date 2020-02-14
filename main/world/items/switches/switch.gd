extends Area2D

export var color = "blue"
export var active = true

signal switched(active)
signal switched_inversed(active)

func _ready():
	$AnimatedSprite.set_sprite_frames(load("res://main/world/items/switches/sprites/animations/"+color+".tres"))
	$AnimatedSprite.play("on" if active else "off")
	
	owner.connect("collision_initialized",self,"_set_collision")
	set_process_unhandled_input(false)
	
## warning-ignore:return_value_discarded
#	connect("body_entered",self,"_on_body_entered")
## warning-ignore:return_value_discarded
#	connect("body_exited",self,"_on_body_exited")
	
	add_to_group(color)

func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	set_collision_mask_bit(player_collision_bits_map[color], true)

func _switch_input(player):
	if overlaps_body(player) and player.color == color:
		switch()

func switch():
	active = !active
	$AnimatedSprite.play("on" if active else "off")
	emit_signal("switched", active)
	emit_signal("switched_inversed", !active)
