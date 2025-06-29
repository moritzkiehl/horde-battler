class_name AttackState extends MovementBaseState

var lockout:float

func enter(state: State) -> void:
	previous_state = state
	lockout = parent.get_weapon_attack_speed()
	if(!parent.attacking):
		start_attack()
	


func process_physics(delta: float) -> State:
	if movement_provider.is_moving():
		attack_move_with_key_down(movement_provider.get_movement_vector())
	parent.move_and_slide()
	return previous_state
		
func start_attack() -> void:
	print("Start Attack")
	parent.attacking = true
	parent.attack()
	initTimer()
	timer.start(lockout)
	timer.timeout.connect(end_attack)


func end_attack() -> void:
	parent.attacking = false
	exit()
	print("End Attack")
	
func attack_move_with_key_down(motion: Vector2) -> void:
	parent.animations.flip_h = motion.x < 0
	parent.velocity = motion.normalized() * move_speed / 2
