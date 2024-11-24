extends Node

var peer = ENetMultiplayerPeer.new()

@export var player_scene : PackedScene
@export var players_container : Node

func _ready():
	if MultiplayerManager.is_host:
		create_host()
	else:
		create_client()
	
	multiplayer.multiplayer_peer = peer
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func create_host():
	peer.create_server(MultiplayerManager.port)
	multiplayer.peer_connected.connect(on_peer_connected)
	multiplayer.peer_disconnected.connect(on_peer_disconnected)
	_add_player.rpc()

func create_client():
	peer.create_client(MultiplayerManager.ip_address, MultiplayerManager.port)

func on_peer_connected(id):
	for player in players_container.get_children():
		_add_player.rpc_id(id, player.name)

	_add_player.rpc(id)
	
	MultiplayerManager.player_connected.emit(id)

func on_peer_disconnected(id):
	MultiplayerManager.player_diconnected.emit(id)

@rpc("any_peer", "call_local")
func _add_player(id = 1):
	var player = player_scene.instantiate() as Node
	player.name = str(id)
	players_container.add_child(player)
