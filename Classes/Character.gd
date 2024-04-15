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
@export var speed: int



#Equipment
var equipment: Dictionary = {
	"right" : null,
	"left": null,
	"head" : null,
	"body" : null,
	"feet" : null,
	"acc" : null
}


#Equipment Stats
var weapon
var armor
var m_weapon
var m_armor
var e_dodge

	
#BattleStats
enum combat_stats {ATTACK, DEFENSE, MAGIC_OFF, MAGIC_DEF, DODGE}
var attack: int
var defense: int
var magic_off: int
var magic_def: int
var dodge: int




func update_stats():
	weapon = 0
	armor = 0
	m_weapon = 0
	m_armor = 0
	e_dodge = 0
	
	
	for item in equipment:
		if equipment[item] == null:
			continue
		weapon += equipment[item].stat_bonus[combat_stats.ATTACK]
		armor += equipment[item].stat_bonus[combat_stats.DEFENSE]
		m_weapon += equipment[item].stat_bonus[combat_stats.MAGIC_OFF]
		m_armor += equipment[item].stat_bonus[combat_stats.MAGIC_DEF]
		e_dodge += equipment[item].stat_bonus[combat_stats.DODGE]
			
	attack = weapon + strength
	defense = armor + int((agility + strength) / 2) 
	magic_off = m_weapon + intellect
	magic_def = m_armor + int(intellect / 2)
	dodge = e_dodge + int(speed / 2)
		
			
func equip(key: String, item):
	equipment[key] = item
	update_stats()
	
	
func unequip(key: String):
	var is_full = InventoryManager.add_item(equipment[key], 1)
	if is_full == null:
		equipment[key] = null
	update_stats()
	
	
func gain_level():
	if level < 100:
		level += 1


func get_stats():
	return [attack, defense, magic_off, magic_def, dodge]
