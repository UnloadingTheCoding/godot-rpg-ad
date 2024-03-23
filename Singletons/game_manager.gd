extends Node

var player_destination: String

var current_state = game_state.GAME_NORMAL
enum game_state {TITLESCREEN, GAME_NORMAL, GAME_CUTSCENE}


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.current_portal.connect(on_destination_update)


# Portal Functions
func on_destination_update(portal_name):
	player_destination = portal_name
