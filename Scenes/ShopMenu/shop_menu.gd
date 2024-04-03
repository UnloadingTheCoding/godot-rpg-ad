extends Area2D

@export var sell_list: Array[Array]

@onready var shop_menu_container = $ShopMenuContainer
@onready var buy_inventory = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/CenterPanels/Selection/BuyInventory
@onready var sell_inventory = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/CenterPanels/Selection/SellInventory

@onready var sell_list_container = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/CenterPanels/Selection/SellInventory/ScrollContainer/SellListContainer
@onready var buy_menu_columns = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/CenterPanels/Selection/BuyInventory/ScrollContainer/BuyMenuColumns
@onready var shop_item = preload("res://Scenes/ShopItem/shop_item.tscn")
@onready var sell_item = preload("res://Scenes/ShopSellItem/ShopSellItem.tscn")

@onready var description_label = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/BottomPanels/Description/DescriptionLabel
@onready var buy_sell_window = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/BottomPanels/BuySellWindow
@onready var buy_sell_item = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/BottomPanels/BuySellWindow/MarginContainer/VBoxContainer/HBoxContainer/Vbox1/BuySellItem
@onready var spin_box = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/BottomPanels/BuySellWindow/MarginContainer/VBoxContainer/HBoxContainer/Vbox2/SpinBox
#BS window labels
@onready var buy_item_name = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/BottomPanels/BuySellWindow/MarginContainer/VBoxContainer/HBoxContainer2/BuyItemName
@onready var total = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/BottomPanels/BuySellWindow/MarginContainer/VBoxContainer/HBoxContainer/Vbox2/Total

@onready var gold_total = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/TopPanels/Money/MarginContainer/GoldTotal




var shop_menu_active: bool = false
var selling: bool = false
var current_item: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_description()
	build_shop_list()
	SignalManager.description_update.connect(on_description_update)
	SignalManager.open_buy_sell_window.connect(on_open_buy_sell_window)
	SignalManager.item_position.connect(on_item_position)
	SignalManager.update_current_buy_sell_item_name.connect(on_update_current_buy_sell_item_name)

func _process(_delta):
	open_menu()
	close_menu()
	activate_close_sell_window()
	set_total()
	update_gold()


func _on_body_entered(body):
	if body == get_tree().get_first_node_in_group("Player"):
		shop_menu_active = true
		
		
func _on_body_exited(body):
	if body == get_tree().get_first_node_in_group("Player"):
		shop_menu_active = false


func build_shop_list():
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
		item.item_id = ml_item.id
		item.item_pos = sell_list.find(item_info)


func build_sell_list():
	var items: Array = InventoryManager.inventory
	

	for item in sell_list_container.get_children():
		sell_list_container.remove_child(item)
		item.queue_free()
	
	for item in items:
		var add_item = sell_item.instantiate()
		sell_list_container.add_child(add_item)
		
		add_item.item_name.text = item[0].item_name
		add_item.icon.texture = item[0].item_texture
		add_item.quantity.text = str(item[1])


func open_menu():
	if shop_menu_active == true and Input.is_action_just_pressed("action_button") and selling == false and GameManager.current_state == GameManager.game_state.GAME_NORMAL:
		SignalManager.change_game_state.emit(GameManager.game_state.GAME_SHOP)
		shop_menu_container.visible = true
		clear_description()
		get_tree().paused = true


func close_menu():
	if shop_menu_active == true and Input.is_action_just_pressed("back") and selling == false and GameManager.current_state == GameManager.game_state.GAME_SHOP:
		SignalManager.change_game_state.emit(GameManager.game_state.GAME_NORMAL)
		shop_menu_container.visible = false
		get_tree().paused = false


func open_buy_sell_window():
	buy_sell_window.visible = true
	selling = true
	
	
func on_open_buy_sell_window(mode):
	buy_sell_item.text = mode	
	spin_box.value = spin_box.min_value
	open_buy_sell_window()
	
	
func activate_close_sell_window():
	var game_shop_state =  GameManager.game_state.GAME_SHOP
	var current_game_state = GameManager.current_state
	if Input.is_action_just_pressed("back") and selling == true and current_game_state == game_shop_state:
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
	build_sell_list()

func _on_exit_pressed():
	SignalManager.change_game_state.emit(GameManager.game_state.GAME_NORMAL)
	shop_menu_container.visible = false
	selling = false
	get_tree().paused = false


func clear_description():
	description_label.text = ""


func set_total():
	if sell_list[current_item]:
		var price = sell_list[current_item][1] 
		total.text = str(spin_box.value * price)
	else:
		total.text = str(0)
		
		
func update_gold():
	gold_total.text = str(InventoryManager.gold)


func on_description_update(text):
	description_label.text = text


func on_update_current_buy_sell_item_name(text):
	buy_item_name.text = text


func _on_cancel_pressed():
	close_sell_window()


func on_item_position(pos):
	current_item = pos


func _on_buy_sell_item_pressed():
	if buy_sell_item.text == "Buy":
		buy_behavior()
	elif buy_sell_item.text == "Sell":
		pass

func buy_behavior():
	var quantity = spin_box.value
	if InventoryManager.gold >= int(total.text) and InventoryManager.inventory.size() != InventoryManager.INVENTORY_CAPACITY:
		var sold_amount = int(total.text)
		InventoryManager.decrease_gold(sold_amount)
		InventoryManager.add_item(InventoryMasterList.inventory[sell_list[current_item][0]], quantity)
	elif InventoryManager.gold < int(total.text) :
		# Replace with warning sound
		SignalManager.warning.emit("Not enough gold!")
		clear_description()
		close_sell_window()
	else:
		SignalManager.warning.emit("Inventory full!")
		clear_description()
		close_sell_window()
