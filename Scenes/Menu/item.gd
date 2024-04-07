extends Control


var item
var sell_price: int
var description: String

@onready var icon = $Sprite2D
@onready var item_name = $Button
@onready var quantity = $Quantity

func get_item():
	return self


func _on_button_pressed():
	var player = get_tree().get_first_node_in_group("Player")
	player.menu.item_descript_label.text = description
