class_name Sword extends WeaponBase

@export var animation: AnimationPlayer


func attack() -> void:
	animation.play("attack")
