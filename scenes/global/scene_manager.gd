extends Node



signal change_scene_requested

var global_currene_scene

###Changing Scenes

func _ready() -> void:
#Based on signal run function to change the scene
	change_scene_requested.connect(change_scene)
	
func change_scene(scene: String) -> void:
#Record the current scene (e.g., for back buttons)
#Go to the new scene
	get_tree().change_scene_to_file(scene)
