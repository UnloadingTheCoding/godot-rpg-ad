extends Node

@onready var warning = $Warning
@onready var warning_message = $Warning/MarginContainer/VBoxContainer/WarningMessage
@onready var no_input_screen = $NoInputScreen
@onready var warning_close = $Warning/MarginContainer/VBoxContainer/HBoxContainer/WarningClose


var player_destination: String = "player_start"

var collected_chests : Array

var current_state = game_state.TITLESCREEN
var previous_state
enum game_state {TITLESCREEN, GAME_NORMAL, GAME_CUTSCENE, GAME_BATTLE, GAME_SHOP, GAME_WARNING, GAME_DIALOG, GAME_MENU}


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.current_portal.connect(on_destination_update)
	SignalManager.change_game_state.connect(on_change_game_state)
	SignalManager.warning.connect(on_warning)


func _process(_delta):
	warning_clear()

# Portal Functions
func on_destination_update(portal_name):
	player_destination = portal_name


func on_change_game_state(state):
	previous_state = current_state
	current_state = state


func on_warning(text):
	previous_state = current_state
	current_state = game_state.GAME_WARNING
	no_input_screen.visible = true
	warning.visible = true
	warning_message.text = text
	

func _on_warning_close_pressed():
	current_state = previous_state
	no_input_screen.visible = false
	warning.visible = false
	SignalManager.warning_closed.emit()


func warning_clear():
	if Input.is_action_just_pressed("action_button") and current_state == game_state.GAME_WARNING:
		warning_close.pressed.emit()

