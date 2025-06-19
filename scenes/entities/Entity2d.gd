class_name Entity2D extends CharacterBody2D

@export var animations: AnimatedSprite2D
@export var state_machine: StateMachine
@export var movement_provider: MovementProvider
@export var health_bar: HealthBar
@export var world:Node2D
@export var health: int
var health_max: int
var health_min: int = 0
var direction = Vector2.RIGHT
var exhausted = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(self.name + " starting with health: " + str(health))
	self.health_max = health
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	health_bar.initHealtBar(self)
	state_machine.init(self, animations, movement_provider)


func take_dmg(value: int):
	health = health - value
	print("Current HP of " + self.name + " " + str(health))
	if health <= health_min:
		queue_free()
		
func get_current_health() -> int:
	return health

func get_max_health() -> int:
	return health_max
	
func update_model_based_on_direction() -> void:
	animations.flip_h = direction.x < 0
	pass
	
func update_facing_direction(motion: Vector2)-> void:
	if direction != motion:
		direction = motion
		update_model_based_on_direction()
		
func get_action_direction() -> Vector2:
	return direction
