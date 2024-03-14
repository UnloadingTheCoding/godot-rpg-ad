extends CanvasLayer


@onready var new_game = %NewGame
@onready var continue_option = %Continue_option
@onready var settings = %Settings
@onready var credits = %Credits



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/test.tscn")
