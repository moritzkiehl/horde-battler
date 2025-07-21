class_name TransitionArea2D extends Area2D

signal player_entered_transition_area(area: TransitionArea2D)

@export_enum("north","east","south","west") var entry_direction
@export var push_distance:int = 16
@export var path_to_new_scene: String
@export var connected_transition_area:String



func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	player_entered_transition_area.emit(self)
	SceneManager.change_scene(path_to_new_scene)
	queue_free()
