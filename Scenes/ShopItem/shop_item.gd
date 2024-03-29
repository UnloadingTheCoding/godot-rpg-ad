extends Control

@onready var item_icon = $BuyItemSelect/ItemIcon
@onready var item_name = $BuyItemSelect/ItemName
@onready var price = $BuyItemSelect/Price

var activate_BS_window: bool = false
var description: String
var item_ref 


func _on_buy_item_select_pressed():
	SignalManager.description_update.emit(description)
	SignalManager.open_buy_sell_window.emit()
	SignalManager.item_position.emit(item_ref)
	#if activate_BS_window == true:
		#SignalManager.open_buy_sell_window.emit()
	#activate_BS_window = true
