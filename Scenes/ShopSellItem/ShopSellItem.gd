extends Control


var item
var sell_price: int	
var pos: int

@onready var icon = $Sprite2D
@onready var item_name = $Button
@onready var quantity = $Quantity



func _on_button_pressed():
	SignalManager.open_buy_sell_window.emit("Sell")
	SignalManager.shop_sell_item_emitter.emit(item_name, sell_price, quantity, pos)
