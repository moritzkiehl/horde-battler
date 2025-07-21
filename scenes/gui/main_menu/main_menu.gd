extends Control

var new_game_scene = "res://scenes/zones/levels/Level1.tscn"


func _on_new_game_pressed() -> void:
	SceneManager.change_scene(new_game_scene)


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	print('Quit')
	get_tree().quit()
