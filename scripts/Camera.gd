extends Camera3D

func _ready():
	if not is_multiplayer_authority():
		queue_free()
