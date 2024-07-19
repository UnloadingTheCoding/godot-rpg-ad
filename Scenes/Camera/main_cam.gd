extends Camera2D

var target_position = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	find_player()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 10))


func find_player() -> void:
	var player_group = get_tree().get_nodes_in_group("Player")
	if player_group.size() > 0:
		var player = player_group[0] as Node2D
		target_position = player.global_position
		
