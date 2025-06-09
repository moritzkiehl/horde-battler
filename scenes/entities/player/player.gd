class_name Player extends Entity2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var direction = Vector2.RIGHT

@onready 
var activeItems = $activeItems;
@onready
var animations = $animations
@export var state_machine:StateMachine;

var mainWeapon:WeaponBase

func _ready() -> void:
	super._ready()
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)
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
	if body.is_in_group('enemies'):
		take_dmg(20)

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group('enemies'):
		if body.has_method('take_dmg'):
			body.take_dmg(20)
			
