extends Resource
class_name InventorySpace

var inventory_item: Array[ItemContainer] = [null]

func add_item(item: ItemContainer) -> bool:
	if inventory_item[0] == null:
		inventory_item[0] = item
		return true
	return false

func get_item() -> ItemContainer:
	var item := inventory_item[0]
	inventory_item[0] = null
	return item

func has_item() -> bool:
	return inventory_item[0] != null
