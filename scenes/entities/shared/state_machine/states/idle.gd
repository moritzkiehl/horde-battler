class_name IdleState extends State

@export var dash_state: State

@export var move_state: State

@export var attack_state: State

@export var exhaust_delay: float = 0.25

func enter(state: State) -> void:
	super(state)
	if previous_state is DashState:
		start_exhaust()
	init_idle()




func process_input(event: InputEvent) -> State:
	if !parent.exhausted:
		if Input.is_action_pressed("dash"):
			return dash_state
		if (
			Input.is_action_pressed("move_left")
			or Input.is_action_pressed("move_right")
			or Input.is_action_pressed("move_up")
			or Input.is_action_pressed("move_down")
		):
			return move_state
		if Input.is_action_pressed("attack"):
			return attack_state
	return 


func init_idle() -> void:
	if parent.direction == Vector2.LEFT or parent.direction == Vector2.RIGHT:
		parent.animations.play("idle_side")
	if parent.direction == Vector2.UP:
		parent.animations.play("idle_up")
	if parent.direction == Vector2.DOWN:
		parent.animations.play("idle")
	parent.velocity.x = 0
	parent.velocity.y = 0


func start_exhaust() -> void:
	parent.exhausted = true
	initTimer()
	timer.start(exhaust_delay)
	print("Start exhaust with duration - " + str(exhaust_delay))
	timer.timeout.connect(end_exhaust)


func end_exhaust() -> void:
	print("Stop exhaust")
	parent.exhausted = false
