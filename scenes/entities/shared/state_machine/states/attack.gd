class_name AttackState extends MovementBaseState

var attacking:bool = false
var lockout:float

func enter(state: State) -> void:
	previous_state = state
	lockout = parent.get_weapon_attack_speed()
	if(!attacking):
		start_attack()
	


func process_physics(delta: float) -> State:
	if !movement_provider.is_moving():
		attack_move_without_key_down()
	else:
		attack_move_with_key_down(movement_provider.get_movement_vector())
	parent.move_and_slide()
	return previous_state
		
func start_attack() -> void:
	print("Start Attack")
	attacking = true
	parent.attack()
	initTimer()
	timer.start(lockout)
	timer.timeout.connect(end_attack)


func end_attack() -> void:
	attacking = false
	exit()
	print("End Attack")
	
func attack_move_without_key_down() -> void:
	if parent.direction == Vector2.LEFT:
		parent.velocity.x = move_speed * Vector2.LEFT.x
	if parent.direction == Vector2.RIGHT:
		parent.velocity.x = move_speed * Vector2.RIGHT.x
	if parent.direction == Vector2.UP:
		parent.velocity.y = move_speed * Vector2.UP.y
	if parent.direction == Vector2.DOWN:
		parent.velocity.y = move_speed * Vector2.DOWN.y


func attack_move_with_key_down(motion: Vector2) -> void:
	parent.animations.flip_h = motion.x < 0
	parent.velocity = motion.normalized() * move_speed / 2
