extends Node2D


@export var lines: PackedStringArray

@onready var timer : Timer = $Timer

var is_speech_available: bool 
var new_lines: PackedStringArray

func _ready():
	new_lines = lines.duplicate()
	SignalManager.is_dialog_complete.connect(is_complete)
	timer.connect("timeout", on_timer_timeout)

func _process(_delta):
	send_lines(new_lines)

func _on_area_2d_body_entered(body):
	if body == get_tree().get_first_node_in_group("Player"):
		is_speech_available = true

func send_lines(line) -> void:
	if Input.is_action_just_pressed("action_button") and is_speech_available == true and timer.is_stopped():
		SignalManager.dialog_lines.emit(line)

func is_complete():
	timer.start()

func on_timer_timeout():
	timer.stop()

func _on_area_2d_body_exited(body):
	if body == get_tree().get_first_node_in_group("Player"):
		is_speech_available = false





