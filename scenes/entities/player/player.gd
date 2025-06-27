class_name Player extends Entity2D

const SPEED = 250.0

@export var activeItems: ItemContainer
var mainWeapon: WeaponBase


func _ready() -> void:
	super._ready()
	for item in activeItems.get_children():
		if item is WeaponBase:
			mainWeapon = item
			mainWeapon.update_attack_speed(attack_speed)
	mainWeapon.init(world, self)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	update_weapon_position()


func _process(delta: float) -> void:
	state_machine.process_frame(delta)


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		take_dmg(20)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		if body.has_method("take_dmg"):
			body.take_dmg(20)


func attack() -> void:
	if mainWeapon != null && mainWeapon.has_method("attack"):
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


func get_mouse_direction() -> Vector2:
	# Calculate the direction vector from the player to the mouse
	return get_global_mouse_position() - global_position


func update_weapon_position() -> void:
	# Get the mouse position in global coordinates

	# Calculate the angle (in radians) from the direction vector
	var angle = get_mouse_direction().angle()

	# Calculate the orbiting node's position
	var orbit_radius = mainWeapon.get_weapon_distance_to_wielder()
	var offset = Vector2(orbit_radius * cos(angle), orbit_radius * sin(angle))

	# Apply the offset to the orbiting node (relative to the player)
	activeItems.position = offset

	#Rotate the orbiting node for visual effect
	activeItems.rotation = angle + PI / 2  # Adjust PI/2 for desired starting orientation
	if offset.x < 0 && activeItems.scale.x > 0:
		activeItems.scale.x *= -1
	elif offset.x > 0 && activeItems.scale.x < 0:
		activeItems.scale.x *= -1
	# Rotate the orbiting node around the player (optional)
	# $OrbitingNode.rotation += orbit_speed * delta


func get_action_direction() -> Vector2:
	return get_mouse_direction()
	
func get_weapon_attack_speed() -> float:
	if mainWeapon != null && mainWeapon.has_method("attack"):
		return mainWeapon.get_current_attack_speed()
	return attack_speed
