extends Node


var current_characters: Dictionary

var test = preload("res://Scenes/Characters/TestChars/TestChar1.tscn")
var test2 = preload("res://Scenes/Characters/TestChars/TestChar2.tscn")

var all_characters: Dictionary = {
	"test" : test,
	"test2" : test2
}


func _ready():
	add_character("test")
	add_character("test2")

func add_character(name_key: String):
	#Complete when Character class is finished
	current_characters[name_key] = all_characters[name_key]
	
func equip_character():
	pass
	

func heal_character():
	pass
	
	
func damage_character():
	pass
	
	
func revive_character():
	pass
	
	
