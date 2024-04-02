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


const INVENTORY_CAPACITY: int =  10
const GOLD_CAPACITY: int = 1000000

var inventory: Array[Array]
var inventory_ref: Dictionary
var inventory_size: int = inventory.size()

var gold: int = 900000

	

# Inventory Methods
func get_inventory() -> Array:
	return inventory


func get_item(id: String, quantity: int, start: int = 0):
	for i in range(start, inventory.size()):
		# check item ID [0] and quantity [1]
		if inventory[i][0].id == id and (inventory[i][1] + quantity) <= 99:
			return i
		elif (inventory[i][1] + quantity) > 99 and (i + 1) < (inventory.size() - 1):
			get_item(id, quantity, i + 1)


func add_item(item, quantity: int):
	var item_to_find = get_item(item.id, quantity)
	if item_to_find != null:
		increase_item(item_to_find, quantity)
	elif inventory_size < INVENTORY_CAPACITY and quantity <= 99:
		print("skipped")
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
		
		
