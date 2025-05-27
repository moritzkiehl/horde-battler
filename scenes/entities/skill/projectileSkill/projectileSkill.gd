class_name ProjectileSkill extends Skill

var speed = 250

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_projectile_body_entered(body: Node2D) -> void:
	print('HIT')
	
func getDamage() -> int:
	return damage
