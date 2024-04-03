extends Control


var item
var sell_price: int

@onready var icon = $Sprite2D
@onready var item_name = $Button
@onready var quantity = $Quantity

func get_item():
	return self
