extends CanvasLayer

@onready var characters = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Characters
var char_box = preload("res://Scenes/Menu/char_stats.tscn")

@onready var inventory = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory
@onready var item_container = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory/VBoxContainer/MarginContainer/ScrollContainer/ItemContainer
@onready var item_descript_label = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory/VBoxContainer/ItemDescriptPanel/ItemDescriptLabel

@onready var status = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status
var current_status_char_reference: int = 0
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
@onready var dodge = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status/MarginContainer/VBoxContainer/StatusBottomContainer/Stats/Dodge
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


@onready var equipment = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment
# Equip nodes
var equip_now: bool = false
# item to equip is [Item_location, ID]
var item_to_equip: Array
var equip_item = preload("res://Scenes/Menu/equip_inv_button.tscn")
@onready var e_inventory = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipInventory/EInventory
var current_equip_char_reference: int = 0
@onready var equip_item_container = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipInventory/EInventory/MarginContainer/ScrollContainer/EquipItemContainer
@onready var equip_char_portrait = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/Panel/EquipCharPortrait
@onready var base_atk = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/BaseStats/BaseAtk
@onready var base_def = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/BaseStats/BaseDef
@onready var base_mag_atk = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/BaseStats/BaseMagAtk
@onready var base_mag_def = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/BaseStats/BaseMagDef
@onready var base_dodge = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/BaseStats/BaseDodge

@onready var g_indicator_1 = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/MarginContainer/BonusIndicators/Control/GIndicator1
@onready var g_indicator_2 = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/MarginContainer/BonusIndicators/Control2/GIndicator2
@onready var g_indicator_3 = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/MarginContainer/BonusIndicators/Control3/GIndicator3
@onready var g_indicator_4 = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/MarginContainer/BonusIndicators/Control4/GIndicator4
@onready var g_indicator_5 = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/MarginContainer/BonusIndicators/Control5/GIndicator5

@onready var r_indicator_1 = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/MarginContainer/BonusIndicators/Control/RIndicator1
@onready var r_indicator_2 = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/MarginContainer/BonusIndicators/Control2/RIndicator2
@onready var r_indicator_3 = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/MarginContainer/BonusIndicators/Control3/RIndicator3
@onready var r_indicator_4 = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/MarginContainer/BonusIndicators/Control4/RIndicator4
@onready var r_indicator_5 = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/MarginContainer/BonusIndicators/Control5/RIndicator5

@onready var bonus_atk = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/Bonus/BonusAtk
@onready var bonus_def = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/Bonus/BonusDef
@onready var bonus_mag_atk = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/Bonus/BonusMagAtk
@onready var bonus_mag_def = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/Bonus/BonusMagDef
@onready var bonus_dodge = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquipStats/Bonus/BonusDodge


@onready var left_label = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquippedItems/EquipLabels1/LeftLabel
@onready var head_label = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquippedItems/EquipLabels1/HeadLabel
@onready var feet_label = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquippedItems/EquipLabels1/FeetLabel
@onready var right_label = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquippedItems/EquipLabels2/RightLabel
@onready var armor_label = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquippedItems/EquipLabels2/ArmorLabel
@onready var acc_label = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment/MarginContainer/VBoxContainer/EquippedItems/EquipLabels2/AccLabel

@onready var equip_confirm = $MarginContainer/EquipConfirm


@onready var magic = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Magic
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
		SignalManager.change_game_state.emit(GameManager.game_state.GAME_MENU)
		self.visible = true
		is_okay_to_exit = true
		get_tree().paused = true
		load_characters()

		
func on_close_menu():
	if is_okay_to_exit and GameManager.current_state == GameManager.game_state.GAME_MENU:
		SignalManager.change_game_state.emit(GameManager.previous_state)
		self.visible = false
		get_tree().paused = false

		
func is_back_pressed():
	close_equip_confirm()
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
	current_status_char_reference = 0
	close_all_windows()
	load_status_window()
	is_okay_to_exit = false
	status.visible = true
	
	
func _on_switch_status_left_pressed():
	current_status_char_reference -= 1
	if current_status_char_reference < 0:
		current_status_char_reference = characters_reference.size() - 1
	load_status_window()


func _on_switch_status_right_pressed():
	current_status_char_reference += 1
	if current_status_char_reference > characters_reference.size() - 1:
		current_status_char_reference = 0
	load_status_window()
	
	
func load_status_window(character: String = characters_reference[current_status_char_reference]):
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
	dodge.text = "Dodge: {}".format({"" : current.dodge})
	stamina.text = "Stamina: {}".format({"" : current.max_stamina})
	speed.text = "Speed: {}".format({"" : current.speed})
	strength.text = "Strength: {}".format({"" : current.strength})
	agility.text = "Agility: {}".format({"" : current.agility}) 
	intellect.text = "intellect: {}".format({"" : current.intellect})
	
	var status_equipment: Array = [right_hand, left_hand, head_equip, armor_equip, feet_equip, special_equip]
	var index = 0
	for item in current.equipment:
		if current.equipment[item] != null:
			var old_text = status_equipment[index].text
			old_text = old_text.erase(7, 10)
			status_equipment[index].text = old_text + "{}".format({"" : current.equipment[item].item_name})
			index += 1
		elif current.equipment[item] == null:
			var old_text = status_equipment[index].text
			status_equipment[index].text = old_text.erase(7, 10)
			index += 1
			

func _on_equip_pressed():
	current_equip_char_reference = 0
	close_all_windows()
	is_okay_to_exit = false
	equipment.visible = true
	load_equip_window()
	
	
func load_equip_window(character: String = characters_reference[current_equip_char_reference]):
	var current: Character = CharacterManager.current_characters[character]
	equip_char_portrait.texture = current.char_portrait
	base_atk.text = "Atk: {}".format({"" : current.attack})
	base_def.text = "Def: {}".format({"" : current.defense})
	base_mag_atk.text = "M.Atk: {}".format({"" : current.magic_off})
	base_mag_def.text = "M.Def: {}".format({"" : current.magic_def})
	base_dodge.text = "Dodge: {}".format({"" : current.dodge})
	
	var equip_window_equipment: Array = [right_label, left_label, head_label, armor_label, feet_label, acc_label]
	var index = 0
	for item in current.equipment:
		if current.equipment[item] != null:
			equip_window_equipment[index].text = "{}".format({"" : current.equipment[item].item_name})
			index += 1
		elif current.equipment[item] == null:
			equip_window_equipment[index].text = ""
			index += 1
	

func _on_switch_equip_left_pressed():
	e_inventory.visible = false
	current_equip_char_reference -= 1
	if current_equip_char_reference < 0:
		current_equip_char_reference = characters_reference.size() - 1
	load_equip_window()
	close_indicators()
	clear_bonuses()


func _on_switch_equip_right_pressed():
	e_inventory.visible = false
	current_equip_char_reference += 1
	if current_equip_char_reference > characters_reference.size() - 1:
		current_equip_char_reference = 0
	load_equip_window()
	close_indicators()
	clear_bonuses()


func build_equip_list(equip_position: String):
	var items: Array = InventoryManager.inventory
	
	for item in items:
		if item[0].item_type == "equip":
			if item[0].equip_position == equip_position:
				var add_item = equip_item.instantiate()
				equip_item_container.add_child(add_item)
				
				add_item.id = item[0].id
				add_item.text = item[0].item_name
				add_item.icon = item[0].item_texture
				add_item.equip_position = item[0].equip_position
				add_item.stat_bonus = item[0].stat_bonus


func clear_build_list():
	for item in equip_item_container.get_children():
		equip_item_container.remove_child(item)
		item.queue_free()


func close_indicators():
	var g_indicators: Array = [g_indicator_1, g_indicator_2, g_indicator_3, g_indicator_4, g_indicator_5]	
	var r_indicators: Array = [r_indicator_1, r_indicator_2, r_indicator_3, r_indicator_4, r_indicator_5]
	
	for indi in g_indicators:
		indi.visible = false
	for indi in r_indicators:
		indi.visible = false


func clear_bonuses():
	var bonus_holder: Array = [bonus_atk, bonus_def, bonus_mag_atk, bonus_mag_def, bonus_dodge]
	for bonus in bonus_holder:
		bonus.visible = false


func update_stat_bonus(bonuses: Array, position: String):
	var bonus_holder: Array = [bonus_atk, bonus_def, bonus_mag_atk, bonus_mag_def, bonus_dodge]
	var g_indicators: Array = [g_indicator_1, g_indicator_2, g_indicator_3, g_indicator_4, g_indicator_5]
	var r_indicators: Array = [r_indicator_1, r_indicator_2, r_indicator_3, r_indicator_4, r_indicator_5]
	
	var current: Character = CharacterManager.current_characters[characters_reference[current_equip_char_reference]]
	var current_char_stats = current.get_stats()
	if current.equipment[position] != null:
		for index in range(current.equipment[position].stat_bonus.size()):
			var current_item_bonus = current.equipment[position].stat_bonus[index]
			if current_item_bonus < bonuses[index]:
				g_indicators[index].visible = true
				bonus_holder[index].visible = true
				bonus_holder[index].text = str(current_char_stats[index] - current_item_bonus + bonuses[index])
			elif current_item_bonus > bonuses[index]:
				bonus_holder[index].visible = true
				bonus_holder[index].text = str(current_char_stats[index] - current_item_bonus + bonuses[index])
				r_indicators[index].visible = true
			else:
				bonus_holder[index].visible = true
				bonus_holder[index].text = str(current_char_stats[index])
	else :
		for index in range(bonuses.size()):
			if bonuses[index] > 0:
				g_indicators[index].visible = true
				bonus_holder[index].visible = true
				bonus_holder[index].text = str(current_char_stats[index] + bonuses[index])
			elif bonuses[index] < 0:
				r_indicators[index].visible = true
				bonus_holder[index].visible = true
				bonus_holder[index].text = str(current_char_stats[index] + bonuses[index])
			else:
				bonus_holder[index].visible = true
				bonus_holder[index].text = str(current_char_stats[index])
				
				
func _on_left_button_pressed():
	e_inventory.visible = true
	equip_now = false
	close_indicators()
	clear_bonuses()
	clear_build_list()
	build_equip_list("left")


func _on_head_button_pressed():
	e_inventory.visible = true
	equip_now = false
	close_indicators()
	clear_bonuses()
	clear_build_list()
	build_equip_list("head")


func _on_feet_button_pressed():
	e_inventory.visible = true
	equip_now = false
	close_indicators()
	clear_bonuses()
	clear_build_list()
	build_equip_list("feet")


func _on_right_button_pressed():
	e_inventory.visible = true
	equip_now = false
	close_indicators()
	clear_bonuses()
	clear_build_list()
	build_equip_list("right")


func _on_armor_button_pressed():
	e_inventory.visible = true
	equip_now = false
	close_indicators()
	clear_bonuses()
	clear_build_list()
	build_equip_list("body")


func _on_acc_button_pressed():
	e_inventory.visible = true
	equip_now = false
	close_indicators()
	clear_bonuses()
	clear_build_list()
	build_equip_list("acc")
	
	
func _on_cancel_equip_pressed():
	close_indicators()
	clear_bonuses()
	close_equip_confirm()


func _on_yes_equip_pressed():
	var current: Character = CharacterManager.current_characters[characters_reference[current_equip_char_reference]]
	current.equip(item_to_equip[0], InventoryMasterList.inventory[item_to_equip[1]])
	InventoryManager.decrease_item(InventoryManager.get_item(item_to_equip[1], 1), 1)
	close_equip_confirm()
	close_indicators()
	clear_bonuses()
	load_equip_window()
	clear_build_list()
	build_equip_list(item_to_equip[0])
	item_to_equip = []


func close_equip_confirm():
	equip_now = false
	equip_confirm.visible = false


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
	e_inventory.visible = false


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


func equip_menu_unequip(label, position: String):
	if label.text != null:
		var current: Character = CharacterManager.current_characters[characters_reference[current_equip_char_reference]]
		current.unequip(position)
		load_equip_window()


func _on_left_label_pressed():
	equip_menu_unequip(left_label, "left")

func _on_head_label_pressed():
	equip_menu_unequip(head_label, "head")


func _on_feet_label_pressed():
	equip_menu_unequip(feet_label, "feet")


func _on_right_label_pressed():
	equip_menu_unequip(right_label, "right")


func _on_armor_label_pressed():
	equip_menu_unequip(armor_label, "body")


func _on_acc_label_pressed():
	equip_menu_unequip(acc_label, "acc")
