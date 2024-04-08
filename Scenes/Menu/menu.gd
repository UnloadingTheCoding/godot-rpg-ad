extends CanvasLayer

@onready var characters = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Characters
var char_box = preload("res://Scenes/Menu/char_stats.tscn")

@onready var inventory = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory
@onready var item_container = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory/VBoxContainer/MarginContainer/ScrollContainer/ItemContainer
@onready var item_descript_label = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory/VBoxContainer/ItemDescriptPanel/ItemDescriptLabel

@onready var status = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status
var current_char_reference: int = 0
# top container status labels
@onready var status_char_portrait = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusTopContainer/Panel/CharPortrait
@onready var status_name = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusTopContainer/TopStatusLabels/StatusName
@onready var status_level = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusTopContainer/TopStatusLabels/StatusLevel
@onready var status_health = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusTopContainer/TopStatusLabels/StatusHealth
@onready var status_mana = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusTopContainer/TopStatusLabels/StatusMana
@onready var status_next_level = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusTopContainer/TopStatusLabels/StatusNextLevel
# Status stats
@onready var attack = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Stats/Attack
@onready var defense = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Stats/Defense
@onready var magic_attack = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Stats/MagicAttack
@onready var magic_defense = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Stats/MagicDefense
@onready var stamina = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Stats/Stamina
@onready var speed = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Stats/Speed
@onready var strength = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Stats/Strength
@onready var agility = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Stats/Agility
@onready var intellect = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Stats/Intellect
# Status equipment
@onready var right_hand = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Equip/RightHand
@onready var left_hand = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Equip/LeftHand
@onready var head_equip = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Equip/HeadEquip
@onready var armor_equip = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Equip/ArmorEquip
@onready var feet_equip = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Equip/FeetEquip
@onready var special_equip = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Equip/SpecialEquip


@onready var magic = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Magic
@onready var equipment = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment
@onready var settings = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Settings
@onready var save = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Save


var characters_reference: Array = CharacterManager.current_characters.keys()
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
	current_char_reference = 0
	close_all_windows()
	load_status_window()
	is_okay_to_exit = false
	status.visible = true
	
	
func _on_switch_status_left_pressed():
	current_char_reference -= 1
	if current_char_reference < 0:
		current_char_reference = characters_reference.size() - 1
	load_status_window()


func _on_switch_status_right_pressed():
	current_char_reference += 1
	if current_char_reference > characters_reference.size() - 1:
		current_char_reference = 0
	load_status_window()
	
	
func load_status_window(character: String = characters_reference[current_char_reference]):
	var current: Character = CharacterManager.current_characters[character]
	status_char_portrait.texture = current.char_portrait
	status_name.text = current.char_name
	status_level.text = "Level: {}".format({"" : current.level})
	status_health.text = "HP: {cur}/{max}".format({"cur" : current.health, "max" : current.max_health})
	status_mana.text = "MP: {cur}/{max}".format({"cur" : current.mana, "max" : current.max_mana})
	status_next_level.text = "Next level: {} ".format({ "" : current.experience_to_next_level - current.experience})
	
	attack.text = "Attack: {}".format({"" : current.attack})
	defense.text = "Defense: {}".format({"" : current.defense})
	magic_attack.text = "M.Atk: {}".format({"" : current.magic_off})
	magic_defense.text = "M.Def: {}".format({"" : current.magic_def})
	stamina.text = "Stamina: {}".format({"" : current.max_stamina})
	speed.text = "Speed: {}".format({"" : current.speed})
	strength.text = "Strength: {}".format({"" : current.strength})
	agility.text = "Agility: {}".format({"" : current.agility}) 
	intellect.text = "intellect: {}".format({"" : current.intellect})
	
	var status_equipment: Array = [right_hand, left_hand, head_equip, armor_equip, feet_equip, special_equip]
	var index = 0
	for item in current.equipment:
		if current.equipment[item] != null:
			print(item)
			status_equipment[index].text = "R: {}".format({"" : current.equipment[item].item_name})
			index += 1
		elif current.equipment[item] == null:
			status_equipment[index].text = ""
			index += 1
			

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


