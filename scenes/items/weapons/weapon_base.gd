class_name WeaponBase extends ItemBase

@export_category("Weapon Information")
@export_group("Base Stats")
@export var weaponDamage: int = 10
@export var weaponDistanceToWielder = 15
@export var baseAttackSpeed:float = 0.5
@export var weapon_type: ItemDefinition.WeaponType = ItemDefinition.WeaponType.NONE 
@export var weapon_sub_type: ItemDefinition.WeaponSubType = ItemDefinition.WeaponSubType.NONE 
var attackSpeed: float
var _orbit_radius: float = 0.0
var _orbit_scale: Vector2 = Vector2(0.5, 1)  # Default: kreisförmig
var _rotation_offset: float = PI / 2

func _ready() -> void:
	attackSpeed = baseAttackSpeed 
	_orbit_radius = get_weapon_distance_to_wielder()

func getDamage() -> int:
	return weaponDamage


func attack() -> void:
	pass
	
func get_weapon_distance_to_wielder() -> int:
	return weaponDistanceToWielder
	
func update_attack_speed(multiplier: float) -> void:
	attackSpeed = baseAttackSpeed / multiplier

func get_current_attack_speed() -> float:
	return attackSpeed
	
func getWeaponType() -> ItemDefinition.WeaponType:
	return weapon_type

func getWeaponSubType() -> ItemDefinition.WeaponSubType:
	return weapon_sub_type

func perform_slash():
	pass # für Fernkampfwaffen z. B. Projektil starten
	
func _update_orbit(angle: float) -> void:
	position = Vector2(
		cos(angle) * _orbit_radius * _orbit_scale.x,
		sin(angle) * _orbit_radius * _orbit_scale.y
	)
	rotation = angle + _rotation_offset
	
func update_weapon_position(get_mouse_direction_func: Callable, flip_sprite := true) -> void:
	var angle = get_mouse_direction_func.call().angle()

	# Neue Position auf der Kreisbahn
	var weapon_position = Vector2(
		cos(angle) * _orbit_radius * _orbit_scale.x,
		sin(angle) * _orbit_radius * _orbit_scale.y
	)
	position = weapon_position
	# Drehung ausrichten
	rotation = angle + _rotation_offset

	# Optionales Flippen des Sprites
	if flip_sprite:
		if weapon_position.x < 0 and scale.x > 0:
			scale.x *= -1
		elif weapon_position.x > 0 and scale.x < 0:
			scale.x *= -1
