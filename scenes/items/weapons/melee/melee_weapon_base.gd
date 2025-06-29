class_name MeleeWeaponBase extends WeaponBase
var slash_angle = 75

func get_slash_angle() -> float:
	return slash_angle
	
func perform_slash():
	var angle = wielder.get_mouse_direction().angle()
	var angle_offset = deg_to_rad(get_slash_angle())
	if rad_to_deg(angle) < -90 or rad_to_deg(angle) > 90:
		angle_offset = -angle_offset

	var start_angle = angle - angle_offset
	var end_angle = angle + angle_offset
	var radius = get_weapon_distance_to_wielder()
	var duration = get_current_attack_speed()

	tween_circular_motion(start_angle, end_angle, radius, duration)


func tween_circular_motion(
	start_angle: float,
	end_angle: float,
	radius: float,
	duration: float,
	rotation_offset := PI / 2,
	trans_type := Tween.TRANS_SINE,
	ease_type := Tween.EASE_IN_OUT
) -> void:
	_orbit_radius = radius
	_rotation_offset = rotation_offset

	var tween := get_tree().create_tween()
	tween.tween_method(self._update_orbit, start_angle, end_angle, duration)\
		.set_trans(trans_type).set_ease(ease_type)
		
		
func attack() -> void:
	triggerAttackAnimation()

	
func triggerAttackAnimation() -> void:
	print(animation.get_animation('attack').length)
	animation.speed_scale =  animation.get_animation('attack').length / attackSpeed
	animation.play("attack")
	
	if getWeaponType() != ItemDefinition.WeaponType.MELEE:
		return  # Since Ranged Weapons dont have a special attack animation (Yet) we leave early

	match getWeaponSubType():
		ItemDefinition.WeaponSubType.SLASH:
			perform_slash()
