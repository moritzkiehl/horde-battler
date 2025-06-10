class_name DashState extends State

@export var dash_duration: float = 0.25

@export var attack_state: State
@export var return_state: State

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
		var movementX = Input.get_axis("move_left", "move_right") * move_speed
		var movementY = Input.get_axis("move_up", "move_down") * move_speed

		if movementX == 0 && movementY == 0:
			dash_without_key_down()
		else:
			dash_with_key_down(movementX, movementY)
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


func dash_with_key_down(movementX: float, movementY: float) -> void:
	if movementX != 0:
		parent.animations.play("move_side")
		if movementX > 0:
			parent.direction = Vector2.RIGHT
		elif movementX < 0:
			parent.direction = Vector2.LEFT
	elif movementY > 0:
		parent.animations.play("move_down")
		parent.direction = Vector2.DOWN
	elif movementY < 0:
		parent.animations.play("move_up")
		parent.direction = Vector2.UP

	parent.animations.flip_h = movementX < 0
	parent.velocity.x = movementX
	parent.velocity.y = movementY
