extends Area2D


@export var scene: String


func _on_body_entered(body):
	if body == get_tree().get_first_node_in_group("Player"):
		ScreenTransition.change_scene(scene)
