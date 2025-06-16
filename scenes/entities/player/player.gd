class_name Player extends Entity2D

const SPEED = 250.0


@export var activeItems: ItemContainer


var mainWeapon: WeaponBase


func _ready() -> void:
	super._ready()
	for item in activeItems.get_children():
		if item is WeaponBase:
			mainWeapon = item


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	var orbit_radius = 11
	state_machine.process_physics(delta)
		# Get the mouse position in global coordinates
	var mouse_position = get_global_mouse_position()

	# Calculate the direction vector from the player to the mouse
	var direction = mouse_position - global_position

	# Calculate the angle (in radians) from the direction vector
	var angle = direction.angle()

	# Calculate the orbiting node's position
	var x = orbit_radius * cos(angle)
	var y = orbit_radius * sin(angle)
	var offset = Vector2(x, y)

	# Apply the offset to the orbiting node (relative to the player)
	activeItems.position = offset

	#Rotate the orbiting node for visual effect
	activeItems.rotation = angle + PI/2 # Adjust PI/2 for desired starting orientation
	if offset.x < 0 && activeItems.scale.x > 0:
		activeItems.scale.x *= -1
	elif offset.x > 0 && activeItems.scale.x < 0:
		activeItems.scale.x *= -1


	# Rotate the orbiting node around the player (optional)
	# $OrbitingNode.rotation += orbit_speed * delta


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
	
func update_model_based_on_direction() -> void:
	#activeItems.position = activeItems.position * get_relative_mouse_position()
	if direction == Vector2.LEFT:
		animations.flip_h = true

	if direction == Vector2.RIGHT && animations.flip_h:
		animations.flip_h = false
	pass
	
