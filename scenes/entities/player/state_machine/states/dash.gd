class_name DashState extends MovementBaseState

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


		if !movement_provider.is_moving():
			dash_without_key_down()
		else:
			dash_with_key_down(movement_provider.get_movement_vector())
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
	exit()
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
