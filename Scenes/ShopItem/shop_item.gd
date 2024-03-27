extends Control

@onready var item_icon = $BuyItemSelect/ItemIcon
@onready var item_name = $BuyItemSelect/ItemName
@onready var price = $BuyItemSelect/Price

var description: String
var item_ref 

func _on_buy_item_select_pressed():
	SignalManager.description_update.emit(description)
