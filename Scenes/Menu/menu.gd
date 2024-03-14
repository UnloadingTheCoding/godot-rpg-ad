extends CanvasLayer

@onready var characters = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Characters
@onready var inventory = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Inventory
@onready var magic = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Magic
@onready var equipment = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Equipment
@onready var settings = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Settings
@onready var save = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Save
@onready var status = $MarginContainer/MainWindow/MarginContainer/HBoxContainer/Output/Status


func _process(_delta):
	if Input.is_action_pressed("back"):
		is_back_pressed()
		
		
func is_back_pressed():
		close_all_windows()
		characters.visible = true
		
		

func _on_items_pressed():
	close_all_windows()
	inventory.visible = true
	
	
func _on_status_pressed():
	close_all_windows()
	status.visible = true


func _on_equip_pressed():
	close_all_windows()
	equipment.visible = true


func _on_magic_pressed():
	close_all_windows()
	magic.visible = true
	

func _on_options_pressed():
	close_all_windows()
	settings.visible = true
	

func _on_save_pressed():
	close_all_windows()
	save.visible = true


func close_all_windows():
	characters.visible = false
	inventory.visible = false
	magic.visible = false
	equipment.visible = false
	settings.visible = false
	save.visible = false
	status.visible = false
