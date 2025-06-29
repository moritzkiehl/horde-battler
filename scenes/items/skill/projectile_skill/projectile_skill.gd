class_name ProjectileSkill extends Skill

var speed = 250
var direction: Vector2 = Vector2()

func launch(launch_position: Vector2, direction: Vector2) -> void:
	global_position = launch_position
	rotation = direction.angle()


func _physics_process(delta):
	position += transform.x * speed * delta


func _on_projectile_body_entered(body: Node2D) -> void:
	print("HIT")


func getDamage() -> int:
	return damage
