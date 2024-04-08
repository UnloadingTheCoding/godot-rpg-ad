extends CanvasLayer

@onready var anim= $AnimationPlayer
@onready var color_rect = $ColorRect


func change_scene(scene: String):
	get_tree().paused = true
	anim.play("transition")
	await anim.animation_finished
	get_tree().change_scene_to_file(scene)
	anim.play("fade_in")
	get_tree().paused =	false
	await anim.animation_finished
	CharacterManager.load_character()
