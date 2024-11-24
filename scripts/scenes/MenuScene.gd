extends Node

@export_category("Scenes")
@export var gameplay_scene : PackedScene

func _on_host_button_pressed():
	MultiplayerManager.is_host = true
	SceneManager.change_to_gameplay_scene()

func _on_connect_button_pressed():
	SceneManager.change_to_gameplay_scene()
