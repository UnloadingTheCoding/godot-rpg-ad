extends Area2D



func _on_body_exited(body):
	if body.is_in_group("npc"):
		body.is_outside_travel_area = true
		body.redirect()



func _on_body_entered(body):
	if body.is_in_group("npc"):
		body.is_outside_travel_area = false