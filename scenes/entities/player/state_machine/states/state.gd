class_name State extends Node

@export var animation_name: String
@export var move_speed: float = 400

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


func initTimer() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
