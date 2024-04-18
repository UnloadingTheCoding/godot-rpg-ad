extends Area2D

@onready var collision_shape_2d = %CollisionShape2D


@export var size : Vector2

func _ready():
	collision_shape_2d.shape.size = size


func _on_body_exited(body):
	if body.is_in_group("npc"):
		print("exited")
		body.is_outside_travel_area = true
		body.redirect()



func _on_body_entered(body):
	if body.is_in_group("npc"):
		print("entered")
		body.is_outside_travel_area = false
