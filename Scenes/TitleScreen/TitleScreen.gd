extends CanvasLayer


@onready var new_game = %NewGame
@onready var continue_option = %Continue_option
@onready var settings = %Settings
@onready var credits = %Credits
@onready var music = $AudioStreamPlayer



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_new_game_pressed():
	#await music_fade()
	SignalManager.change_game_state.emit(GameManager.game_state.GAME_NORMAL)
	var scene = "res://Scenes/test.tscn"
	ScreenTransition.change_scene(scene)


func _on_continue_option_pressed():
	print("pressed continue")


func _on_settings_pressed():
	print("pressed settings")


func _on_credits_pressed():
	print("pressed credits")
	

""" Consider turning music into autoload to control fading and better manage audio"""

#func music_fade():
	#var tween = create_tween()
	#tween.tween_property(music, "volume_db", -40.0, 0.5)
	#await tween.finished
	#
