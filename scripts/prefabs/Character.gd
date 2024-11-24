extends CharacterBody3D
class_name Character

@export var base_movement_speed = 7.5
@export var look_sensitivity = 0.005

@export var model : Node

var last_position : Vector3
var last_rotation : Vector3

func _ready():
	if not is_multiplayer_authority():
		set_process_input(false)
		set_physics_process(false)
	else:
		model.queue_free()
		MultiplayerManager.player_connected.connect(on_player_connected)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * look_sensitivity)
		_sync_rotation.rpc(rotation)

func _physics_process(_delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * base_movement_speed
		velocity.z = direction.z * base_movement_speed
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()
	
	if last_position != position:
		_sync_position.rpc(position)
		last_position = position

@rpc("any_peer", "call_remote")
func _sync_position(new_position : Vector3):
	position = new_position

@rpc("any_peer", "call_remote")
func _sync_rotation(new_rotation : Vector3):
	rotation = new_rotation

func on_player_connected(id):
	_sync_position.rpc_id(id, position)
	_sync_rotation.rpc_id(id, rotation)
