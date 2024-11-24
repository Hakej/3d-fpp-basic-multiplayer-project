extends Node

func _enter_tree():
	set_multiplayer_authority(name.to_int())
