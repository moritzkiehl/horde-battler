class_name Enemy extends Entity2D

var run_speed = 75
var player = null
var default_health = 50
@export var health_bar: HealthBar


func _ready() -> void:
	super._ready()
	if health > default_health:
		print(get_max_health()/default_health)
		self.scale = self.scale * (get_max_health()/default_health) 

	health_bar.initHealtBar(self)


func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * run_speed
	move_and_slide()


func _on_DetectRadius_body_entered(body: Node2D):
	print("Body of type " + body.name + " entered")
	if body.is_in_group("players"):
		player = body


func _on_DetectRadius_body_exited(body: Node2D):
	if body == player:
		player = null


func _on_hitbox_area_entered(area: Node2D) -> void:
	if area.get_parent().has_method("getDamage"):
		self.take_dmg(area.get_parent().getDamage())


func take_dmg(value: int):
	super.take_dmg(value)
	health_bar.update()
