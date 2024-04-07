extends CanvasLayer

@onready var characters = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Characters
var char_box = preload("res://Scenes/Menu/char_stats.tscn")

@onready var inventory = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory
@onready var item_container = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory/VBoxContainer/MarginContainer/ScrollContainer/ItemContainer
@onready var magic = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Magic
@onready var equipment = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment
@onready var settings = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Settings
@onready var save = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Save
@onready var status = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status

@onready var item_descript_label = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory/VBoxContainer/ItemDescriptPanel/ItemDescriptLabel

var item_scene = preload("res://Scenes/Menu/item.tscn")

var is_okay_to_exit: bool


func _process(_delta):
	on_open_menu()
	if Input.is_action_just_pressed("back"):
		on_close_menu()
		is_back_pressed()

		
func on_open_menu():
	if Input.is_action_just_pressed("inventory") and GameManager.current_state == GameManager.game_state.GAME_NORMAL:
		self.visible = true
		is_okay_to_exit = true
		get_tree().paused = true
		load_characters()

		
func on_close_menu():
	if is_okay_to_exit and GameManager.current_state == GameManager.game_state.GAME_NORMAL:
		self.visible = false
		get_tree().paused = false

		
func is_back_pressed():
	close_all_windows()
	is_okay_to_exit = true
	characters.visible = true
	
	
func load_characters():
	var container = characters.get_child(0).get_child(0)
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()
	for character in CharacterManager.current_characters:
		var current = CharacterManager.current_characters[character]
		var char_box_stats = char_box.instantiate()
		container.add_child(char_box_stats)
		char_box_stats.char_name.text = current.char_name
		char_box_stats.lvl_quantity.text = str(current.level)
		char_box_stats.current_hp.text = str(current.health)
		char_box_stats.max_hp.text = str(current.max_health)
		char_box_stats.current_mp.text = str(current.mana)
		char_box_stats.max_mp.text = str(current.max_mana)
		char_box_stats.texture_rect.texture = current.char_portrait
		if current.level < 99:
			char_box_stats.progress_bar.max_value =  CharacterManager.level_guide[current.level][0]
		else:
			char_box_stats.progress_bar.max_value = 0
		if current.level == 1:
			char_box_stats.progress_bar.value = current.experience
		else:
			char_box_stats.progress_bar.value = abs(CharacterManager.level_guide[current.level - 1][1] - current.experience)
		print(char_box_stats.progress_bar.value)
		print(char_box_stats.progress_bar.max_value)

		
func _on_items_pressed():
	close_all_windows()
	item_descript_label.text = ""
	for item in item_container.get_children():
		item_container.remove_child(item)
		item.queue_free()
	build_inventory_list()
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
		var add_item = item_scene.instantiate()
		item_container.add_child(add_item)
		
		add_item.item_name.text = item[0].item_name
		add_item.icon.texture = item[0].item_texture
		add_item.quantity.text = str(item[1])
		add_item.sell_price = item[0].sell_price
		add_item.description = item[0].item_description
