class_name ItemBase extends Node2D
var world: Node2D
var wielder: Entity2D
const itemType = ItemDefinition.ItemCategory.WEAPON
var itemData:Dictionary = {}

func _ready() -> void:
	updateItemData()

func init(world:Node2D, character:Entity2D) -> void:
	self.world = world
	self.wielder = character
	updateItemData()
	

func getItemInformationAsJson() -> String:
	return JSON.stringify(itemData);
	
	
func updateItemData()-> void:
	itemData["item_type"] = itemType
	itemData["world"] = world
	itemData["wielder"] = wielder
	
