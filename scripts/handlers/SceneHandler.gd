extends Node
class_name SceneHandler

@export var menu_scene : PackedScene
@export var gameplay_scene : PackedScene

func _ready():
	SceneManager.scene_handler = self
	change_to_menu_scene()

func change_to_menu_scene():
	switch_to_scene(menu_scene)

func change_to_gameplay_scene():
	switch_to_scene(gameplay_scene)

func switch_to_scene(scene : PackedScene):
	for child in get_children():
		child.queue_free()

	var new_scene = scene.instantiate()
	add_child(new_scene)
