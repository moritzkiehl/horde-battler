extends Entity2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0
@onready var activeItems = $activeItems;
var mainWeapon:WeaponBase

signal attack_trigger


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("ui_left", "ui_right")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var directiony := Input.get_axis("ui_up", "ui_down")

	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)


	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.is_action_pressed("attack"):
		if mainWeapon != null && mainWeapon.has_method('getAnimation'):
			var attackAnimation:AnimationPlayer = mainWeapon.getAnimation()
			if attackAnimation.has_animation('attack'):
				attackAnimation.play('attack')
			attack_trigger.emit()

func _ready() -> void:
	super._ready()
	for item in activeItems.get_children():
		if item is WeaponBase:
			mainWeapon = item


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group('enemies'):
		take_dmg(20)

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group('enemies'):
		if body.has_method('take_dmg'):
			body.take_dmg(20)
			
