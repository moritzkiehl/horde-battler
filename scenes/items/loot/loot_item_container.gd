class_name LootItemContainer extends ItemContainer

func _on_pick_up_area_entered(body: Node2D) -> void:
	if not body is Player:
		return
		
	
