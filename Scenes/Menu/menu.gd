extends CanvasLayer

@onready var characters = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Characters
@onready var inventory = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory
@onready var item_container = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory/VBoxContainer/MarginContainer/ScrollContainer/ItemContainer
@onready var magic = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Magic
@onready var equipment = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment
@onready var settings = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Settings
@onready var save = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Save
@onready var status = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status

var is_okay_to_exit: bool


func _ready():
	build_inventory_list()


func _process(_delta):
	on_open_menu()
	if Input.is_action_just_pressed("back"):
		on_close_menu()
		is_back_pressed()

		
func on_open_menu():
	if Input.is_action_pressed("inventory") and GameManager.current_state == GameManager.game_state.GAME_NORMAL:
		self.visible = true
		is_okay_to_exit = true
		get_tree().paused = true

		
func on_close_menu():
	if is_okay_to_exit:
		self.visible = false
		get_tree().paused = false

		
func is_back_pressed():
	close_all_windows()
	is_okay_to_exit = true
	characters.visible = true

		
func _on_items_pressed():
	close_all_windows()
	is_okay_to_exit = false
	inventory.visible = true	

	
func _on_status_pressed():
	close_all_windows()
	is_okay_to_exit = false
	status.visible = true


func _on_equip_pressed():
	close_all_windows()
	is_okay_to_exit = false
	equipment.visible = true


func _on_magic_pressed():
	close_all_windows()
	is_okay_to_exit = false
	magic.visible = true

	
func _on_options_pressed():
	close_all_windows()
	is_okay_to_exit = false
	settings.visible = true

	
func _on_save_pressed():
	close_all_windows()
	is_okay_to_exit = false
	save.visible = true


func close_all_windows():
	characters.visible = false
	inventory.visible = false
	magic.visible = false
	equipment.visible = false
	settings.visible = false
	save.visible = false
	status.visible = false


func build_inventory_list():
	var items: Array = InventoryManager.inventory
	
	for item in items:
		item_container.add_child(item)
