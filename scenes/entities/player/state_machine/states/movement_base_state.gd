class_name MovementBaseState extends State

@export var move_speed: float = 400

var latest_directionX: float
var latest_directionY: float

func _input(event: InputEvent) -> void:
	save_last_direction(event)
	
func save_last_direction(event: InputEvent) -> void:
	if event.is_action_pressed("move_right"):
		latest_directionX = 1
	elif event.is_action_pressed("move_left"):
		latest_directionX = -1

	if event.is_action_pressed("move_up"):
		latest_directionY = -1
	elif event.is_action_pressed("move_down"):
		latest_directionY = 1
