extends Node

func _ready():
	var args = Array(OS.get_cmdline_args())
	if args.has("server"):
		get_window().position = Vector2(3440, 900)
	else:
		get_window().position = Vector2(3440 + 1152, 900)
