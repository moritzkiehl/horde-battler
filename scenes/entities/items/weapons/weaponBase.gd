class_name WeaponBase extends Node2D

@export_category("Weapon Information")
@export_group("Base Stats")
@export var weaponDamage = 10

func getAnimation():AnimationPlayer

func attackConnects(body: Node2D) -> void:
	print(body.get_parent())
	if body.is_in_group('enemies') && body.has_method('take_dmg'):
		body.take_dmg(weaponDamage)
