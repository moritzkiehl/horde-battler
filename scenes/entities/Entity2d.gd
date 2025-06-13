class_name Entity2D extends CharacterBody2D
@export_category("EntityInformation")
@export_group("Health")
@export var health: int
@export var health_max: int = 100
var health_min: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(self.name + " starting with health: " + str(health))


func take_dmg(value: int):
	health = health - value
	print("Current HP of " + self.name + " " + str(health))
	if health <= health_min:
		queue_free()
		
func get_current_health() -> int:
	return health

func get_max_health() -> int:
	return health_max
