class_name MoveState extends MovementBaseState

@export var attack_state: State
@export var idle_state: State
@export var dash_state: State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("dash"):
		return dash_state
	if Input.is_action_just_pressed("attack"):
		return attack_state
	return null


func process_physics(delta: float) -> State:
	var move_left = Input.get_action_strength("move_left")
	var move_right = Input.get_action_strength("move_right")
	var move_up = Input.get_action_strength("move_up")
	var move_down = Input.get_action_strength("move_down")
	
	print(move_left)

	if move_left == 0 && move_right == 0 && move_up == 0 && move_down == 0:
		return idle_state

	var motion = Vector2()


	if (move_left || move_right) && latest_directionX:
		motion.x = latest_directionX
	if (move_up || move_down) && latest_directionY:
		motion.y = latest_directionY

	if motion.x != 0:
		parent.animations.play("move_side")
		if motion.x > 0:
			parent.direction = Vector2.RIGHT
		elif motion.x < 0:
			parent.direction = Vector2.LEFT
	elif motion.y > 0:
		parent.animations.play("move_down")
		parent.direction = Vector2.DOWN
	elif motion.y < 0:
		parent.animations.play("move_up")
		parent.direction = Vector2.UP

	parent.animations.flip_h = motion.x < 0
	parent.velocity = motion.normalized() * move_speed
	parent.move_and_slide()
	
	return null
