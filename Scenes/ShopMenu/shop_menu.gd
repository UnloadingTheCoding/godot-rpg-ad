extends Area2D

@onready var shop_menu_container = $ShopMenuContainer


var selling: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	open_menu()
	close_menu()

func _on_body_entered(body):
	if body == get_tree().get_first_node_in_group("Player"):
		selling = true
		
		
func _on_body_exited(body):
	if body == get_tree().get_first_node_in_group("Player"):
		selling = false


func open_menu():
	if selling == true and Input.is_action_pressed("action_button"):
		shop_menu_container.visible = true
		get_tree().paused = true


func close_menu():
	if selling == true and Input.is_action_pressed("back"):
		shop_menu_container.visible = false
		get_tree().paused = false
