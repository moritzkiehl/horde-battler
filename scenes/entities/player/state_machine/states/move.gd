class_name MoveState extends State

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
	var movementX = Input.get_axis("move_left", "move_right") * move_speed
	var movementY = Input.get_axis("move_up", "move_down") * move_speed

	if movementX == 0 && movementY == 0:
		return idle_state
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
	parent.move_and_slide()

	return null
