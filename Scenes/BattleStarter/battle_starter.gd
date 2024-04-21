extends Area2D

@onready var timer = $Timer

var player : Player


func _process(_delta):
	battle_timer_controller()


func _on_body_entered(body):
	if body == get_tree().get_first_node_in_group("Player"):
		player = body
		battle_countdown_starter()


func _on_peace_starter_body_exited(body):
	if body == get_tree().get_first_node_in_group("Player"):
		timer.stop()
		
		
func battle_countdown_starter():
	var time = randi_range(4, 10)
	timer.wait_time = time
	timer.start()
	
	
func battle_timer_controller():
	if player == null:
		return
	if player.velocity == Vector2.ZERO:
		timer.paused = true
	else:
		timer.paused = false


func _on_timer_timeout():
	#Replace Timer reset with Battle starter and reset timer after battle completion
	battle_countdown_starter()	


