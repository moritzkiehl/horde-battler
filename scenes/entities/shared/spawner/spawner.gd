class_name Spawner extends Node2D

var entityScene = preload("res://scenes/entities/enemies/enemy.tscn")

@export var world: Zone
#timer to define how often a unit should be spawned
@export var spawn_timer: Timer
#How many units should be spawned at the same time
@export var spawn_amount: int = 1
#Number between 0-100 to define a % Chance to spawn a unit
@export var spawn_variance: int = 0

@onready var spawn_area: CollisionShape2D = $SpawnArea/CollisionShape2D


func _ready() -> void:
	spawn_timer.timeout.connect(spawn)


func spawn() -> void:
	if randi_range(0, 100) > spawn_variance:
		for enemy_count in spawn_amount:
			var entitiy = entityScene.instantiate()
			var rect = spawn_area.shape.get_rect()
			var spawn_position = global_position + Vector2(randi_range(rect.position.x, rect.end.x), randi_range(rect.position.y, rect.end.y))
			world.add_child(entitiy)
			print("Spawn @" + str(spawn_position))
			entitiy.global_position =  spawn_position
