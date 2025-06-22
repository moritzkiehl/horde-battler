class_name Enemy extends Entity2D

var run_speed = 75
var target_player:Entity2D = null
var default_health = 50
var starting_scale: Vector2
var minimum_scale:Vector2 = Vector2(0.5,0.5)

func _ready() -> void:
	super._ready()
	starting_scale = scale * (float(health_max)/default_health)
	print(starting_scale)
	scale = starting_scale
	health_bar.initHealtBar(self)


func _physics_process(delta):
	velocity = Vector2.ZERO
	print(target_player)
	if target_player:
		velocity = position.direction_to(target_player.position) * run_speed
	move_and_slide()


func _on_DetectRadius_body_entered(body: Node2D):
	print("Body of type " + body.name + " entered")
	if body.is_in_group("players"):
		target_player = body


func _on_DetectRadius_body_exited(body: Node2D):
	if body == target_player:
		target_player = null


func _on_hitbox_area_entered(area: Node2D) -> void:
	if area.get_parent().has_method("getDamage"):
		self.take_dmg(area.get_parent().getDamage())


func take_dmg(value: int):
	super.take_dmg(value)
	self.scale_size_based_on_health()
	health_bar.update()
	
func scale_size_based_on_health() -> void:
	print(health_max/float(health))
	var new_scale = starting_scale * (float(health) / health_max)
	
	if new_scale > minimum_scale:
		self.scale = new_scale
