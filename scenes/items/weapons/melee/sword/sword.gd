class_name Sword extends MeleeWeaponBase

@export var animation: AnimationPlayer

func attack() -> void:
	print(attackSpeed)
	print(animation.get_animation('attack').length)
	animation.speed_scale =  animation.get_animation('attack').length / attackSpeed
	animation.play("attack")
