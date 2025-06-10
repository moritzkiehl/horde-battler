class_name WeaponBase extends Node2D

@export_category("Weapon Information")
@export_group("Base Stats")
@export var weaponDamage: int = 10


func getDamage() -> int:
	return weaponDamage


func attack() -> void:
	pass
