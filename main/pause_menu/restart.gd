extends TextureButton

func _ready():
	connect("pressed", owner.owner, "_restart_level")
