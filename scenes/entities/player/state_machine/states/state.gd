class_name State extends Node

@export var animation_name: String
@export var move_speed: float = 400

var latest_directionX: float
var latest_directionY: float

var timer: Timer

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var previous_state: State

## Hold a reference to the parent so that it can be controlled by the state
var parent: Player


func enter(state: State) -> void:
	print(parent)
	previous_state = state
	parent.animations.play(animation_name)


func exit() -> void:
	pass


func process_input(event: InputEvent) -> State:
	return null


func process_frame(delta: float) -> State:
	return null


func process_physics(delta: float) -> State:
	return null
	

func _input(event: InputEvent) -> void:
	save_last_direction(event)

func initTimer() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	
func save_last_direction(event: InputEvent) -> void:
	if event.is_action_pressed("move_right"):
		latest_directionX = 1
	elif event.is_action_pressed("move_left"):
		latest_directionX = -1

	if event.is_action_pressed("move_up"):
		latest_directionY = -1
	elif event.is_action_pressed("move_down"):
		latest_directionY = 1
