class_name Staff extends RangedWeaponBase

@onready var animation = $AnimationPlayer
@export var skill:Skill


func attack() -> void:
	animation.play("attack")
	var projectile = skill.instantiate()
	world.add_child(projectile)
	projectile.launch(wielder.global_position, wielder.get_action_direction())
