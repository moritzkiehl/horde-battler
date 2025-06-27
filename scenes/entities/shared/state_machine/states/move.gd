class_name MoveState extends MovementBaseState

@export var attack_state: State
@export var idle_state: State
@export var dash_state: State


func process_physics(delta: float) -> State:
	var motion = movement_provider.get_movement_vector()
	if Input.is_action_just_pressed("dash"):
		return dash_state
	if Input.is_action_pressed("attack"):
		return attack_state
	if movement_provider.is_moving():
		if motion.x != 0:
			parent.animations.play("move_side")
			if motion.x > 0:
				parent.update_facing_direction(Vector2.RIGHT)
			elif motion.x < 0:
				parent.update_facing_direction(Vector2.LEFT)
		elif motion.y > 0:
			parent.animations.play("move_down")
			parent.update_facing_direction(Vector2.DOWN)
		elif motion.y < 0:
			parent.animations.play("move_up")
			parent.update_facing_direction(Vector2.UP)

		parent.velocity = motion.normalized() * move_speed
		parent.move_and_slide()
		return
	else:
		return idle_state
