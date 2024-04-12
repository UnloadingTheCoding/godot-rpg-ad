extends Resource

class_name EquipItem

@export var id: String
@export var item_name: String
@export var item_texture: Texture2D
@export var item_description: String
@export var sell_price: int

var quantity: int


var item_root
@export var item_type: String 
@export var equip_position: String
@export var item_category: String

# Size 5 array of bonuses
@export var stat_bonus: Array[int] = [0,0,0,0,0]

func get_item():
	return self
