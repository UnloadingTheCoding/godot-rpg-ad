extends CharacterBody2D

class_name Player
 
@onready var animation_tree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var anim = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var menu = $Menu

# Movement
#speed - 120 for testing 70 for normal gameplay
const SPEED = 120
var direction = Vector2.ZERO
var last_known_direction = Vector2.ZERO


func _physics_process(_delta):
	get_movement()
	move_and_slide()



func get_movement():
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction != Vector2.ZERO:
		animation_tree.set("parameters/walk/blend_position", direction)
		state_machine.travel("walk")
		
		if Input.is_action_pressed("move_up"): 
			velocity = Vector2.UP * SPEED
		elif Input.is_action_pressed("move_down"): 
			velocity = Vector2.DOWN * SPEED	
		elif Input.is_action_pressed("move_left"):
			velocity = Vector2.LEFT * SPEED
		elif Input.is_action_pressed("move_right"): 
			velocity = Vector2.RIGHT * SPEED
		last_known_direction = direction
	elif direction == Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", last_known_direction)
		state_machine.travel("idle")
		velocity = Vector2.ZERO
		
