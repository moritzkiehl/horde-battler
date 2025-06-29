class_name ItemBase extends Node2D
var world: Node2D
var wielder: Entity2D
const itemType = ItemDefinition.ItemCategory.WEAPON

func init(world:Node2D, character:Entity2D) -> void:
	self.world = world
	self.wielder = character
