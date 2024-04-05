extends Node

class_name Character
	
	
var char_name: String
var char_sprite: Sprite2D


#Stats	
var max_health: int 
var health: int 

var max_mana: int 
var mana: int 

var max_stamina: int 	
var stamina: int 

var strength: int 
var intellect: int 
var agility: int 


#Equipment
var equipment: Dictionary = {
	"left" : null,
	"right": null,
	"head" : null,
	"body" : null,
	"special" : null
}


#Equipment Stats
var weapon
var armor

	
#BattleStats
var attack: int
var defense: int
var magic_off: int
var magic_def: int
var speed: int


func update_stats():
	weapon = 0
	armor = 0
	
	for item in equipment:
		if equipment[item].item_type == "weapon":
			weapon += equipment[item].stat_bonus 
		elif equipment[item].item_type == "armor":
			weapon += equipment[item].stat_bonus
		if equipment[item].item_type == null:
			weapon += 0 
			
	attack = weapon + strength
	defense = armor + int((agility + strength) / 2) 

			
func equip(key: String, item):
	equipment[key] = item
	update_stats()
	
func unequip(key: String):
	equipment[key] = null
	update_stats()
	
	
