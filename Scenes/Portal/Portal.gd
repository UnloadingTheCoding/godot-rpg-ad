extends Area2D


@export var scene: String
@export var portal_name: String
@export var destination: String


@onready var start = $Start


func _ready():
	if GameManager.player_destination == portal_name:
		set_player()


func _on_body_entered(body):
	if body == get_tree().get_first_node_in_group("Player") and scene != "":
		SignalManager.current_portal.emit(destination)
		ScreenTransition.change_scene(scene)
		
	
func set_player():
	var player = get_tree().get_first_node_in_group("Player")
	if player != null:
		player.global_position = start.global_position
