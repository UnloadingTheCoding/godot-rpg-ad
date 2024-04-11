extends Button


var id: String
var item_name: String
var item_texture: Texture2D
var item_description: String

var quantity: int


var item_root
var item_type: String 
var equip_position: String

var stat_bonus: Array


func _on_pressed():
	var player = get_tree().get_first_node_in_group("Player") as Player
	
	
	if player != null:
		player.menu.update_stat_bonus(stat_bonus, equip_position)
		if player.menu.equip_now == true:
			player.menu.item_to_equip = [equip_position, id]
			player.menu.equip_confirm.visible = true
		
		if player.menu.equip_now == false:
			player.menu.equip_now = true
		
