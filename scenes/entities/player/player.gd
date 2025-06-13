class_name Player extends Entity2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var direction = Vector2.RIGHT
var exhausted = false;

@onready var activeItems = $activeItems
@export var animations: AnimatedSprite2D
@export var state_machine: StateMachine
@export var movement_provider: MovementProvider
@export var health_bar: HealthBar


var mainWeapon: WeaponBase


func _ready() -> void:
	super._ready()
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	health_bar.initHealtBar(self)
	state_machine.init(self, animations, movement_provider)
	for item in activeItems.get_children():
		if item is WeaponBase:
			mainWeapon = item


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)


func _process(delta: float) -> void:
	state_machine.process_frame(delta)


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		take_dmg(20)


func _on_hitbox_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("enemies"):
		if body.has_method("take_dmg"):
			body.take_dmg(20)
			

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.is_action_pressed("attack"):
		if mainWeapon != null && mainWeapon.has_method('attack'):
				mainWeapon.attack()
				
func take_dmg(value: int):
	super.take_dmg(value)
	health_bar.update()
