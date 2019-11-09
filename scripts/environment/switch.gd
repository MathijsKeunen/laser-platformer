extends Area2D

export var color = "blue"
export var active = true

signal switched(active)
signal switched_inversed(active)

func _ready():
	$AnimatedSprite.set_sprite_frames(load("res://assets/environment items/swhitches/animations/"+color+".tres"))
	$AnimatedSprite.play("on" if active else "off")
	
# warning-ignore:return_value_discarded
	owner.connect("collision_initialized",self,"_set_collision")
	set_process_unhandled_input(false)
	
	connect("body_entered",self,"_on_body_entered")
	connect("body_exited",self,"_on_body_exited")

func _set_collision(player_collision_bits_map, wall_collision_bits_map):
	set_collision_mask_bit(player_collision_bits_map[color], true)

func _unhandled_input(event):
	if event.is_action_pressed("ui_select") and owner.get_node("player_controller").current_color == color:
		switch()

func switch():
	active = !active
	$AnimatedSprite.play("on" if active else "off")
	emit_signal("switched", active)
	emit_signal("switched_inversed", !active)

# warning-ignore:unused_argument
func _on_body_entered(body):
	set_process_unhandled_input(true)

# warning-ignore:unused_argument
func _on_body_exited(body):
	set_process_unhandled_input(false)

