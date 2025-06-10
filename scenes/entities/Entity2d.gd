class_name Entity2D extends CharacterBody2D
var health: int
@export_category("EntityInformation")
@export_group("Health")
@export var health_max: int = 100
var health_min: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = health_max
	print(self.name + " starting with health: " + str(health))


func take_dmg(value: int):
	health = health - value
	print("Current HP of " + self.name + " " + str(health))
	if health <= health_min:
		queue_free()
