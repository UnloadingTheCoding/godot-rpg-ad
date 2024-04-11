extends Node

const INVENTORY_CAPACITY: int =  50
const GOLD_CAPACITY: int = 1000000

var inventory: Array[Array]
var inventory_size: int = inventory.size()

var gold: int = 999999

	

# Inventory Methods
func get_inventory() -> Array:
	return inventory


func get_item(id: String, quantity: int, start: int = 0):
	for i in range(start, inventory.size()):
		# check item ID [0] and quantity [1]
		if inventory[i][0].id == id and inventory[i][1] <= 98:
			return i
		elif (inventory[i][1] + quantity) > 99 and (i + 1) < (inventory.size() - 1):
			continue


func add_item(item, quantity: int):
	if item == null:
		return
	var item_to_find = get_item(item.id, quantity)
	if item_to_find != null:
		increase_item(item_to_find, quantity)
	elif inventory_size < INVENTORY_CAPACITY and quantity <= 99:
		inventory.append([item, quantity])
		inventory_size += 1

	
func remove_item(item: int):
	inventory.remove_at(item)
	if inventory_size > 0:
		inventory_size -= 1

	
func increase_item(item: int, amount: int):
	var quantity: int = inventory[item][1] 
	if (quantity + amount) <= 99:
		inventory[item][1] += amount
	else:
		var difference = quantity + amount - 99
		inventory[item][1] = 99
		add_item(inventory[item][0], difference)
	
	
func decrease_item(item: int, amount: int):
	var quantity: int = inventory[item][1] 
	if (quantity - amount) >= 1:
		inventory[item][1] -= amount
	else:
		remove_item(item)
	
	
# Gold Methods
func get_gold():
	return gold
	
	
func increase_gold(amount: int):
	if (gold + amount) < GOLD_CAPACITY:
		gold += amount
		
		
func decrease_gold(amount: int):
	if (gold - amount) >= 0:
		gold -= amount
		
		
