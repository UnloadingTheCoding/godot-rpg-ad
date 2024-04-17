extends CharacterBody2D


@export var NPCSprite: Texture
@export var speed: int
@export var npc_dialog: PackedStringArray

@onready var animation_tree = $AnimationTree
@onready var state_machine = $AnimationTree.get("parameters/playback")
@onready var move_timer = $move_timer
@onready var anim = $Anim
@onready var npc_texture = $NPCTexture
@onready var ray_cast_2d = $RayCast2D

var is_outside_travel_area: bool = false
var redirected : bool
var direction = Vector2.ZERO
var last_known_direction = Vector2.ZERO

var move_left : Vector2 = Vector2.LEFT
var move_right : Vector2 = Vector2.RIGHT
var move_up : Vector2 = Vector2.UP
var move_down : Vector2 = Vector2.DOWN
var move_stop : Vector2 = Vector2.ZERO
var was_moving : bool

var directions : Array

func _ready():
	npc_texture.texture = NPCSprite
	directions = [move_left, move_right, move_down, move_up]
	

func _physics_process(_delta):
	is_RC_colliding()
	get_movement()
	move_and_slide()


func get_direction() -> Vector2:
	return directions.pick_random()

func get_movement():
	
	if direction == move_stop:
		ray_cast_2d.enabled = false
	else:
		ray_cast_2d.enabled = true
		if direction == move_left:
			ray_cast_2d.target_position = Vector2(-15, 0)
		elif direction == move_right:
			ray_cast_2d.target_position = Vector2(15, 0)
		elif  direction == move_up:
			ray_cast_2d.target_position = Vector2(0, -15)
		elif direction == move_down:
			ray_cast_2d.target_position = Vector2(0, 15)
	
	if direction != Vector2.ZERO:
		animation_tree.set("parameters/walk/blend_position", direction)
		state_machine.travel("walk")
		
		if direction == move_up: 
			velocity = Vector2.UP * speed
		elif direction == move_down: 
			velocity = Vector2.DOWN * speed	
		elif direction == move_left:
			velocity = Vector2.LEFT * speed
		elif direction == move_right: 
			velocity = Vector2.RIGHT * speed
		last_known_direction = direction
	elif direction == Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", last_known_direction)
		state_machine.travel("idle")
		velocity = Vector2.ZERO


func _on_move_timer_timeout():
	var wait_time = randi_range(2, 4)
	if was_moving:
		was_moving = false
		direction = move_stop
		move_timer.wait_time = wait_time
		move_timer.start()
	elif redirected:
		wait_time = randi_range(1, 2)
		var reverse = -1
		was_moving = true
		redirected = false
		direction = last_known_direction * reverse
		move_timer.wait_time = wait_time
		move_timer.start()
	else:
		was_moving = true
		direction = get_direction()
		while direction == last_known_direction:
			direction = get_direction()
			print(direction)
		#else: 
			#direction = last_known_direction * -1
		move_timer.wait_time = wait_time
		move_timer.start()
		last_known_direction = direction


func redirect():
	last_known_direction = direction
	#move_timer.stop()
	direction = move_stop
	redirected = true
	#move_timer.start()
	
	
func is_RC_colliding():
	if ray_cast_2d.is_colliding():
		print("is colliding")
		redirect()


func if_needs_to_return_to_travel_area():
	if is_outside_travel_area:
		pass
