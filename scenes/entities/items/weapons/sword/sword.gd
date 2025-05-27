class_name Sword extends WeaponBase

@onready var animation:AnimationPlayer = $AnimationPlayer

func attack() -> void:
	animation.play('attack')
