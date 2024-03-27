extends Node

const INVENTORY_CAPACITY: int =  50
const GOLD_CAPACITY: int = 1000000

var inventory: Array[Array]
var inventory_size: int = inventory.size()

var gold: int

# Inventory Methods
func get_inventory() -> Array:
	return inventory


func get_item(position: int) -> Array:
	var item = inventory[position][0]
	var quantity: int = inventory[position][1] 
	return [item, quantity]


func add_item(item, quantity):
	if inventory_size < INVENTORY_CAPACITY:
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
		
		
