extends Area2D

@export var sell_list: Array[Array]

@onready var shop_menu_container = $ShopMenuContainer
@onready var buy_inventory = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/CenterPanels/Selection/BuyInventory
@onready var sell_inventory = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/CenterPanels/Selection/SellInventory

@onready var buy_menu_columns = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/CenterPanels/Selection/BuyInventory/ScrollContainer/BuyMenuColumns
@onready var shop_item = preload("res://Scenes/ShopItem/shop_item.tscn")

@onready var description_label = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/BottomPanels/Description/DescriptionLabel
@onready var buy_sell_window = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/BottomPanels/BuySellWindow


var shop_menu_active: bool = false
var selling: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_description()
	build_sell_list()
	SignalManager.description_update.connect(on_description_update)
	SignalManager.open_buy_sell_window.connect(on_open_buy_sell_window)


func _process(_delta):
	open_menu()
	close_menu()
	activate_close_sell_window()



func _on_body_entered(body):
	if body == get_tree().get_first_node_in_group("Player"):
		shop_menu_active = true
		
		
func _on_body_exited(body):
	if body == get_tree().get_first_node_in_group("Player"):
		shop_menu_active = false


func build_sell_list():
	for item_info in sell_list:
		var item_info_name = item_info[0]
		var item_info_price = item_info[1]
		
		var ml_item = InventoryMasterList.inventory[item_info_name]
		var item = shop_item.instantiate()
		buy_menu_columns.add_child(item)
		
		item.item_icon.texture = ml_item.item_texture
		item.item_name.text = ml_item.item_name
		item.description = ml_item.item_description
		item.price.text = str(item_info_price)
		item.item_ref = item


func open_menu():
	if shop_menu_active == true and Input.is_action_just_pressed("action_button") and selling == false:
		SignalManager.change_game_state.emit(GameManager.game_state.GAME_SHOP)
		shop_menu_container.visible = true
		clear_description()
		get_tree().paused = true


func close_menu():
	if shop_menu_active == true and Input.is_action_just_pressed("back") and selling == false:
		SignalManager.change_game_state.emit(GameManager.game_state.GAME_NORMAL)
		shop_menu_container.visible = false
		get_tree().paused = false


func open_sell_window():
	buy_sell_window.visible = true
	selling = true
	
	
func on_open_buy_sell_window():
	open_sell_window()
	
	
func activate_close_sell_window():
	if Input.is_action_just_pressed("back") and selling == true:
		close_sell_window()
		
		
func close_sell_window():
	buy_sell_window.visible = false
	selling = false


func _on_buy_pressed():
	buy_inventory.visible = true
	sell_inventory.visible = false


func _on_sell_pressed():
	clear_description()
	close_sell_window()
	buy_inventory.visible = false
	sell_inventory.visible = true


func _on_exit_pressed():
	shop_menu_container.visible = false
	get_tree().paused = false


func clear_description():
	description_label.text = ""


func on_description_update(text):
	description_label.text = text


func _on_cancel_pressed():
	close_sell_window()
