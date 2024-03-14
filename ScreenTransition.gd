extends CanvasLayer

@onready var anim= $AnimationPlayer
@onready var color_rect = $ColorRect


func fade_to_black():
	anim.play("transition")
	await anim.animation_finished

	queue_free()

func change_scene(scene: String):
	await fade_to_black()
	get_tree().change_scene_to_file(scene)
