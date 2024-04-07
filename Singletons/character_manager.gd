extends Node

var level_guide: Dictionary = { 0 : [0, 0]}
var current_characters: Dictionary

var test = preload("res://Scenes/Characters/TestChars/TestChar1.tscn")
var test2 = preload("res://Scenes/Characters/TestChars/TestChar2.tscn")

var all_characters: Dictionary = {
	"test" : test,
	"test2" : test2
}


func _ready():
	build_level_guide()
	add_character("test")
	add_character("test2")
	
func _process(delta):
	if Input.is_action_just_pressed("test"):
		add_experience("test", 50)

func add_character(name_key: String, lvl: int = 1, experience: int = level_guide[0][0]):
	#Complete when Character class is finished
	current_characters[name_key] = all_characters[name_key].instantiate()
	current_characters[name_key].level = lvl
	if lvl > 1:
		current_characters[name_key].experience = level_guide[lvl-1][0]
		current_characters[name_key].experience_to_next_level = level_guide[lvl][1] + level_guide[lvl][0]
	else:
		current_characters[name_key].experience = experience
		current_characters[name_key].experience_to_next_level = level_guide[lvl][0]
		
func equip_character():
	pass
	

func heal_character():
	pass
	
	
func damage_character():
	pass
	
	
func revive_character():
	pass
	
	
func build_level_guide():
	var inc = 1.07
	var experience = 300
	var inc_counter = 10
	var total = 0
	
	for level in range(1, 100):
		if inc_counter <= 0:
			inc += 0.001
			inc_counter = 10
		
		total += experience
		level_guide[level] = [experience, total]
		experience = int(experience * inc)
		inc_counter -= 1


func add_experience(character: String, experience: int):
	current_characters[character].experience += experience 
	if current_characters[character].experience >= current_characters[character].experience_to_next_level and  \
	current_characters[character].level < 99:
		raise_level(character)
	

func raise_level(character: String):
	var level = current_characters[character].level
	current_characters[character].level += 1
	current_characters[character].experience_to_next_level = level_guide[level][1] + level_guide[level+1][0]
	
