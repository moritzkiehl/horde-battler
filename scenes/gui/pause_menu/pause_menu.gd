extends Control

@onready var animation: AnimationPlayer = $AnimationPlayer
var paused: bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_menu"):
		if paused == false:
			get_tree().paused = true
			paused = true
			animation.play("Pause")
		elif paused == true:
			get_tree().paused = false
			paused = false
			animation.play("Unpause")


func _on_continue_pressed() -> void:
	get_tree().paused = false
	paused = false
	animation.play("Unpause")


func _on_options_pressed() -> void:
	pass  # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass  # Replace with function body.
