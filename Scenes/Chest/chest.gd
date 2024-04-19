extends Node2D


@export var chest_id: String
@export var item_to_collect : String
@export var is_gold : bool 
@export var gold : int
@onready var chest_sprite = %ChestSprite

var is_collectable : bool = false
var is_collected : bool = false


func _ready():
	if_has_been_collected()
	SignalManager.warning_closed.connect(on_warning_closed)
	
	
func _process(_delta):
	collect_loot()



func chest_opened():
	chest_sprite.texture.region = Rect2(337, 34, 14, 13)


func _on_collect_area_body_entered(body):
	if body == get_tree().get_first_node_in_group("Player"):
		is_collectable = true


func collect_loot():
	if Input.is_action_just_pressed("action_button") and is_collectable and not is_collected:
		is_collectable = false
		is_collected = true
		get_tree().paused = true
		if is_gold:
			InventoryManager.increase_gold(gold)
			SignalManager.warning.emit("{} gold received".format({"" : gold}))
		else:
			var item = InventoryMasterList.inventory[item_to_collect]
			InventoryManager.add_item(item, 1)
			SignalManager.warning.emit("{} received".format({"" : item.item_name}))
		GameManager.collected_chests.append(chest_id)
		chest_opened()
		

func if_has_been_collected():
	if chest_id in GameManager.collected_chests:
		is_collected = true
		chest_opened()


func on_warning_closed():
	get_tree().paused = false
