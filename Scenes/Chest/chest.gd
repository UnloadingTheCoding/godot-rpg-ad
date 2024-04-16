extends Node2D

@export var item_to_collect : String

@onready var chest_sprite = %ChestSprite

var is_collectable : bool = false
var is_collected : bool = false
var item

func _ready():
	item = InventoryMasterList.inventory[item_to_collect]


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
		InventoryManager.add_item(item, 1)
		SignalManager.warning.emit("{} received".format({"" : item.item_name}))
		chest_opened()
		
