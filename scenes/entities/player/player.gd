class_name Player extends Entity2D

const SPEED = 250.0

@export var mainHand: ItemContainer
var mainWeapon: WeaponBase


func _ready() -> void:
	super._ready()
	for item in mainHand.get_children():
		if item is WeaponBase:
			mainWeapon = item
			mainWeapon.update_attack_speed(attack_speed)
	mainWeapon.init(world, self)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	if !(attacking):
		mainWeapon.update_weapon_position(func(): return get_mouse_direction())

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
	if mainWeapon == null or not mainWeapon.has_method("attack"):
		return  # early exit in case we have no weapon

	mainWeapon.attack()

	if mainWeapon.getWeaponType() != ItemDefinition.WeaponType.MELEE:
		return  # Since Ranged Weapons dont have a special attack animation (Yet) we leave early

	match mainWeapon.getWeaponSubType():
		ItemDefinition.WeaponSubType.SLASH:
			mainWeapon.perform_slash()

func take_dmg(value: int):
	super.take_dmg(value)
	health_bar.update()


func update_model_based_on_direction() -> void:
	#mainHand.position = mainHand.position * get_relative_mouse_position()
	if direction == Vector2.LEFT:
		animations.flip_h = true

	if direction == Vector2.RIGHT && animations.flip_h:
		animations.flip_h = false
	pass


func get_mouse_direction() -> Vector2:
	# Calculate the direction vector from the player to the mouse
	return get_global_mouse_position() - global_position


func _update_slash_arc(angle: float) -> void:
	var orbit_radius = mainWeapon.get_weapon_distance_to_wielder()
	mainHand.position = Vector2(cos(angle), sin(angle)) * orbit_radius
	mainHand.rotation = angle + PI / 2


func get_action_direction() -> Vector2:
	return get_mouse_direction()


func get_weapon_attack_speed() -> float:
	if mainWeapon != null && mainWeapon.has_method("attack"):
		return mainWeapon.get_current_attack_speed()
	return attack_speed
