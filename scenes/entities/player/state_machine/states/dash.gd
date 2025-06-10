class_name DashState extends State

@export var dash_duration: float = 0.25

@export var return_state: State
@export var attack_state: State


var dashing: bool = false


func enter(state: State) -> void:
	super(state)
	print(parent)
	start_dash()
	parent.animations.play(animation_name)


func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("attack"):
		return attack_state
	return null


func process_physics(delta: float) -> State:
	if dashing:
		var move_left = Input.get_action_strength("move_left")
		var move_right = Input.get_action_strength("move_right")
		var move_up = Input.get_action_strength("move_up")
		var move_down = Input.get_action_strength("move_down")


		if move_left == 0 && move_right == 0 && move_up == 0 && move_down == 0:
			dash_without_key_down()
		else:
			var motion = Vector2()
			if (move_left || move_right) && latest_directionX:
				motion.x = latest_directionX
			if (move_up || move_down) && latest_directionY:
				motion.y = latest_directionY
			dash_with_key_down(motion)
		parent.move_and_slide()
		return null
	else:
		return return_state


func start_dash() -> void:
	print("Start Dash")
	dashing = true
	initTimer()
	timer.start(dash_duration)
	timer.timeout.connect(end_dash)


func end_dash() -> void:
	dashing = false
	print("End Dash")


func dash_without_key_down() -> void:
	if parent.direction == Vector2.LEFT:
		parent.velocity.x = move_speed * Vector2.LEFT.x
	if parent.direction == Vector2.RIGHT:
		parent.velocity.x = move_speed * Vector2.RIGHT.x
	if parent.direction == Vector2.UP:
		parent.velocity.y = move_speed * Vector2.UP.y
	if parent.direction == Vector2.DOWN:
		parent.velocity.y = move_speed * Vector2.DOWN.y


func dash_with_key_down(motion: Vector2) -> void:
	parent.animations.flip_h = motion.x < 0
	parent.velocity = motion.normalized() * move_speed
