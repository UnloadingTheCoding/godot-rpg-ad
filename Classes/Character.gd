extends Node

class_name Character

var experience: int
var experience_to_next_level: int
var level: int

@export var char_name: String
@export var char_sprite: Texture2D
@export var char_portrait: AtlasTexture


#Stats	
@export var max_health: int 
var health: int 

@export var max_mana: int 
var mana: int 

@export var max_stamina: int 	
var stamina: int 

@export var strength: int 
@export var intellect: int 
@export var agility: int 



#Equipment
var equipment: Dictionary = {
	"right" : null,
	"left": null,
	"head" : null,
	"body" : null,
	"feet" : null,
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
		if equipment[item] == null:
			continue
		elif equipment[item].item_type == "weapon":
			weapon += equipment[item].stat_bonus 
		elif equipment[item].item_type == "armor":
			weapon += equipment[item].stat_bonus

			
	attack = weapon + strength
	defense = armor + int((agility + strength) / 2) 
	
			
func equip(key: String, item):
	equipment[key] = item
	update_stats()
	
	
func unequip(key: String):
	equipment[key] = null
	update_stats()
	
	
func gain_level():
	if level < 100:
		level += 1
