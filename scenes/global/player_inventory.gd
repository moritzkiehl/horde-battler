extends Node

var weapon: ItemContainer
var helmet: ItemContainer
var body_armour: ItemContainer
var gloves: ItemContainer
var boots: ItemContainer

const INVENTORY_WIDTH: int = 4
const INVENTORY_LENGTH: int = 4
const CHEST_SIZE: int = 99

var inventory: Array[InventorySpace] = []
var chest: Array[InventorySpace] = []

func _ready() -> void:
	init_inventory_space(inventory, INVENTORY_LENGTH * INVENTORY_WIDTH)
	init_inventory_space(chest, CHEST_SIZE)

func init_inventory_space(target: Array[InventorySpace], size: int) -> void:
	target.resize(size)
	for i in size:
		target[i] = InventorySpace.new()

func _process(delta: float) -> void:
	if chest_has_any_item():
		print("Chest contains items: ", JSON.stringify(chest))

func add_item_to_inventory_position(item: ItemContainer, position: int = 0) -> bool:
	if position < 0 or position >= inventory.size() or inventory[position].has_item():
		position = find_available_space(inventory)
		if position == -1:
			return false
	inventory[position].add_item(item)
	return true

func remove_item_from_inventory_position(position: int = 0) -> ItemContainer:
	if is_valid_slot(inventory, position) and inventory[position].has_item():
		return inventory[position].get_item()
	return null

func add_item_to_chest(item: ItemContainer) -> void:
	var pos = find_available_space(chest)
	if pos != -1:
		chest[pos].add_item(item)

func remove_item_from_chest_position(position: int = 0) -> ItemContainer:
	if is_valid_slot(chest, position) and chest[position].has_item():
		return chest.pop_at(position)
	return null

func find_available_space(container: Array[InventorySpace]) -> int:
	for i in container.size():
		if not container[i].has_item():
			return i
	return -1

func inventory_has_any_item() -> bool:
	return has_any_item(inventory)

func chest_has_any_item() -> bool:
	return has_any_item(chest)

func has_any_item(container: Array[InventorySpace]) -> bool:
	for space in container:
		if space and space.has_item():
			return true
	return false

func is_valid_slot(container: Array[InventorySpace], index: int) -> bool:
	return index >= 0 and index < container.size() and container[index] != null
