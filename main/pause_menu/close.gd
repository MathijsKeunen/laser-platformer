extends TextureButton

func _ready():
	connect("pressed", owner.owner, "_exit_level")
