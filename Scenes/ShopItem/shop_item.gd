extends Control

@onready var item_icon = $BuyItemSelect/ItemIcon
@onready var item_name = $BuyItemSelect/ItemName
@onready var price = $BuyItemSelect/Price

var activate_BS_window: bool = false
var description: String
var item_ref 
var item_pos: int
var item_id: String


func _on_buy_item_select_pressed():
	SignalManager.description_update.emit(description)
	SignalManager.open_buy_sell_window.emit()
	SignalManager.item_position.emit(item_pos)
	SignalManager.update_current_buy_sell_item_name.emit(item_name.text)
