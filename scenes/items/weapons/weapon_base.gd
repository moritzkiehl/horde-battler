class_name WeaponBase extends ItemBase

@export_category("Weapon Information")
@export_group("Base Stats")
@export var weaponDamage: int = 10
@export var weaponDistanceToWielder = 15
@export var baseAttackSpeed:float = 0.5
@export var weapon_type: ItemDefinition.WeaponType = ItemDefinition.WeaponType.NONE 
@export var weapon_sub_type: ItemDefinition.WeaponSubType = ItemDefinition.WeaponSubType.NONE 
var attackSpeed: float

func _ready() -> void:
	attackSpeed = baseAttackSpeed 

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
