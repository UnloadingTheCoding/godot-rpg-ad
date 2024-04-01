extends Node

"""Build wrapper Dictionary with array of item indices in main list. Make a get function
that checks if index is max quantity and then moves to next index other wise work with
current index
do something to reference available index (havent thought about it yet)

also create individual resources with polymorphic function for easy use and different behavior
or at very least come up with common name and 'pass' on each function so you know what to do
when implementing battle system

then save these notes somewhere else for later ref

basically rework this class
remove reduntdant shit
 leave some fuckin notes on what function affects so you dont have to relearn your own shit
"""


const INVENTORY_CAPACITY: int =  50
const GOLD_CAPACITY: int = 1000000

var inventory: Array[Array]
var inventory_ref: Dictionary
var inventory_size: int = inventory.size()

var gold: int = 5000


func _ready():
	pass
	#add_item(InventoryMasterList.inventory["hp_potion"], 5)
	#add_item(InventoryMasterList.inventory["mp_potion"], 5)
	

# Inventory Methods
func get_inventory() -> Array:
	return inventory


func get_item(id: String):
	for i in range(inventory.size()):
		if inventory[i][0].id == id:
			pass
	#inventory.filter(func(id): id == )
	#var item = inventory[position][0]
	#var quantity: int = inventory[position][1] 
	#return [item, quantity]


func add_item(item, quantity):
	if inventory_size < INVENTORY_CAPACITY and quantity < 100:
		inventory.append([item, quantity])
		inventory_size += 1


func remove_item(item: int):
	inventory.pop_at(item)
	if inventory_size > 0:
		inventory_size -= 1

	
func increase_item(item: int, amount: int):
	var quantity: int = inventory[item][1] 
	if (quantity + amount) < 100:
		inventory[item][1] += amount

	
func decrease_item(item: int, amount: int):
	var quantity: int = inventory[item][1] 
	if (quantity - amount) > 0:
		inventory[item][1] -= amount
	
	
# Gold Methods
func get_gold():
	return gold
	
	
func increase_gold(amount: int):
	if (gold + amount) < GOLD_CAPACITY:
		gold += amount
		
		
func decrease_gold(amount: int):
	if (gold - amount) >= 0:
		gold -= amount
		
		
