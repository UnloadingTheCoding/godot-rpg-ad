extends Node

var player_destination: String

var current_state = game_state.TITLESCREEN
enum game_state {TITLESCREEN, GAME_NORMAL, GAME_CUTSCENE, GAME_BATTLE, GAME_SHOP}


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.current_portal.connect(on_destination_update)
	SignalManager.change_game_state.connect(on_change_game_state)

# Portal Functions
func on_destination_update(portal_name):
	player_destination = portal_name

func on_change_game_state(state):
	current_state = state
