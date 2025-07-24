class_name ItemContainer extends Node2D

@export var item:ItemBase


func get_item() -> ItemBase:
	return item
	
func insert_item(item_to_insert:ItemBase) -> void:
	if item != null:
		item = item_to_insert	
		
func _on_pick_up_area_entered(body: Node2D) -> void:
	print(body.to_string() + ' Entered')
	if body is Player:
		body.pickup_item(self)
		get_parent().call_deferred('remove_child',self)
		print("Removed " + self.to_string() + " from tree")
	
		

	
