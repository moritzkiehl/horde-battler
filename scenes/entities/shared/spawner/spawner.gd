class_name Spawner extends Node2D

var entityScene = preload("res://scenes/entities/enemies/enemy.tscn")

@export var world: Zone
#timer to define how often a unit should be spawned
@export var spawn_timer: Timer
#How many units should be spawned at the same time
@export var spawn_amount: int = 1
#Number between 0-100 to define a % Chance to spawn a unit
@export var spawn_variance: int = 0

@export var spawn_areas: Array[CollisionShape2D]


func _ready() -> void:
	spawn_timer.timeout.connect(spawn)


func spawn() -> void:
	for spawn_area in spawn_areas:
		if randi_range(0, 100) >= spawn_variance:
			var rect = spawn_area.shape.get_rect()
			for enemy_count in spawn_amount:
				var entitiy = entityScene.instantiate()
				world.add_child(entitiy)
				print(rect.size)
				var positionInArea = Vector2(randf_range(rect.position.x, rect.position.x + rect.size.x), randf_range(rect.position.y, rect.position.y + rect.size.y))
				var spawn_position = spawn_area.global_position + positionInArea
				print("Spawn @" + str(spawn_position))
				entitiy.global_position = spawn_position
