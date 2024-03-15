extends Node

class_name Character
	
#Equipment
var left: Equip
var right: Equip
var head: Equip
var body: Equip
var special: Equip
	
#BattleStats
var attack
var defense
var magic_off
var magic_def


func _init(hp: int, mp: int, stam: int, strength: int, intellect: int, agi: int
			):
	
	self.health = hp
	self.max_health = hp
	self.mana = mp
	self.max_mana = mp
	self.stamina = stam
	self.max_stamina = stam
	
	self.strength = strength
	self.intellect = intellect
	self.agility = agi
	

	
