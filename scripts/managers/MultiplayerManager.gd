extends Node

var is_host = false

var ip_address = "127.0.0.1"
var port = 1337

@warning_ignore("unused_signal")
signal player_connected(id)
@warning_ignore("unused_signal")
signal player_disconnected(id)
