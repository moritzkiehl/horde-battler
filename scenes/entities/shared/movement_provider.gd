class_name MovementProvider extends Node

var direction: Vector2
var latest_directionX: float
var latest_directionY: float
var moving = false

func get_movement_vector() -> Vector2:
	return direction
	
func get_latest_directionX() -> float:
	return latest_directionX
	
func get_latest_directionY() -> float:
	return latest_directionY
	
func is_moving()->bool:
	return moving
	
func _ready() -> void:
	direction = Vector2(0,0)
