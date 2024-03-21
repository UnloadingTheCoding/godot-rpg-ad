extends Area2D

@export var sell_list: Array[String]

@onready var shop_menu_container = $ShopMenuContainer
@onready var buy_inventory = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/CenterPanels/Selection/BuyInventory
@onready var sell_inventory = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/CenterPanels/Selection/SellInventory

@onready var buy_menu_columns = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/CenterPanels/Selection/BuyInventory/ScrollContainer/BuyMenuColumns
@onready var shop_item = preload("res://Scenes/ShopItem/shop_item.tscn")

@onready var description_label = $ShopMenuContainer/PanelContainer/MarginContainer/VBoxContainer/Description/DescriptionLabel


var selling: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_description()
	SignalManager.description_update.connect(on_description_update)
	
	for key in sell_list:
		var ml_item = InventoryMasterList.inventory[key]
		var item = shop_item.instantiate()
		buy_menu_columns.add_child(item)
		item.item_icon.texture = ml_item.item_texture
		item.item_name.text = ml_item.item_name
		item.description = ml_item.item_description
		item.price.text = str(500)
		item.item_ref = item


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


func _on_buy_pressed():
	buy_inventory.visible = true
	sell_inventory.visible = false


func _on_sell_pressed():
	buy_inventory.visible = false
	sell_inventory.visible = true


func _on_exit_pressed():
	shop_menu_container.visible = false
	get_tree().paused = false


func clear_description():
	description_label.text = ""


func on_description_update(text):
	description_label.text = text
