extends Node

var player_destination: String


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.current_portal.connect(on_destination_update)
	


func on_destination_update(portal_name):
	player_destination = portal_name


