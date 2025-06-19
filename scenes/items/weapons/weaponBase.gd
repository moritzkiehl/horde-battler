class_name WeaponBase extends ItemBase

@export_category("Weapon Information")
@export_group("Base Stats")
@export var weaponDamage: int = 10
@export var weaponDistanceToWielder = 15


func getDamage() -> int:
	return weaponDamage


func attack() -> void:
	pass
	
func get_weapon_distance_to_wielder() -> int:
	return weaponDistanceToWielder
