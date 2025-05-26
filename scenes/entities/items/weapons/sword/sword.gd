class_name Sword extends WeaponBase

@onready var animation = $AnimationPlayer

func getAnimation() -> AnimationPlayer:
	return animation
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	attackConnects(body)
