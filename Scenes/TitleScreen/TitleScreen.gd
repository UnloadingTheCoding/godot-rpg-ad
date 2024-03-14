extends CanvasLayer


@onready var new_game = %NewGame
@onready var continue_option = %Continue_option
@onready var settings = %Settings
@onready var credits = %Credits



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_new_game_pressed():
	var scene = "res://Scenes/test.tscn"
	ScreenTransition.change_scene(scene)


func _on_continue_option_pressed():
	print("pressed continue")


func _on_settings_pressed():
	print("pressed settings")


func _on_credits_pressed():
	print("pressed credits")
