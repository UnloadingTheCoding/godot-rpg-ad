extends Control


var item

@onready var icon = $Sprite2D
@onready var item_name = $Button
@onready var quantity = $Quantity



func _on_button_pressed():
	SignalManager.open_buy_sell_window.emit("Sell")
	
