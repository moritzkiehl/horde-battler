class_name Staff extends WeaponBase

@onready var animation = $AnimationPlayer
var projectileSkill = preload("res://scenes/skill/projectileSkill/projectileSkill.tscn")


func attack() -> void:
	animation.play("attack")
	var projectile = projectileSkill.instantiate()
	world.add_child(projectile)
	projectile.launch(wielder.global_position, wielder.get_action_direction())
