extends Area2D

###
#updates the animation of the flag and signals the flag controller
#configures the collision of the flag
#contains basic information about the flag
###

signal entered(color)
signal exited(color)

export var color = "blue"

onready var sprite = $AnimatedSprite

func _ready():
	#initializes the animation of the flag
	sprite.set_sprite_frames(load("res://main/world/items/flags/sprites/animations/" + color + ".tres"))
	sprite.play("hanging")
	#signals to update the animation of the flag
	connect("body_entered",self,"_on_flag_body_entered")
	connect("body_exited",self,"_on_flag_body_exited")
	#signals to check if all flags are reached
	connect("entered",$"..","_on_flag_entered")
	connect("exited",$"..","_on_flag_exited")
	#signals to update the player head in the HUD
	connect("entered",owner.get_node("HUD"),"activate_check_mark")
	connect("exited",owner.get_node("HUD"),"deactivate_check_mark")
	#signal to configure collision
	owner.connect("collision_initialized",self,"_set_collision")

func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	#sets collision of the flag
	set_collision_mask_bit(player_collision_bits_map[color], true)

func _on_flag_body_entered(body):
	#called when a player of the right color enters the flag
	sprite.play("waving")
	emit_signal("entered",color)

func _on_flag_body_exited(body):
	#called when a player of the right color exits the flag
	sprite.play("hanging")
	emit_signal("exited",color)
