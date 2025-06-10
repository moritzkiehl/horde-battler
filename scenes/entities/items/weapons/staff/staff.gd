class_name Staff extends WeaponBase

@onready var animation = $AnimationPlayer
var projectileSkill = preload("res://scenes/entities/skill/projectileSkill/projectileSkill.tscn")


func attack() -> void:
	animation.play("attack")
	var projectile = projectileSkill.instantiate()
	owner.add_child(projectile)
