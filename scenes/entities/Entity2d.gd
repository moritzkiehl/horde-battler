class_name Entity2D extends CharacterBody2D

@export var animations: AnimatedSprite2D
@export var state_machine: StateMachine
@export var movement_provider: MovementProvider
@export var health_bar: HealthBar
@export var world: Node2D
@export var health: int
@export var attack_speed: float = 1
var attacking: bool = false

var health_max: int
var health_min: int = 0
var direction = Vector2.RIGHT
var exhausted = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(self.name + " starting with health: " + str(health))
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


func update_facing_direction(motion: Vector2) -> void:
	if direction != motion:
		direction = motion
		update_model_based_on_direction()


func get_action_direction() -> Vector2:
	return direction


func attack() -> void:
	pass


func update_weapon_position() -> void:
	pass


func update_weapon_position_for_attack() -> void:
	pass


func get_weapon_attack_speed() -> float:
	return attack_speed
	
	
func apply_knockback(current_pos: Vector2, source_pos: Vector2, distance: float, duration := 0.2) -> void:
	var direction = (current_pos - source_pos).normalized()
	var target_pos = current_pos + direction * distance

	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_pos, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func apply_knockback_from_weapon(weapon: WeaponBase, duration := 0.2) -> void:
	if(weapon.getKnockbackDistance() > 0):
		apply_knockback(global_position, weapon.global_position, weapon.getKnockbackDistance(), duration)
