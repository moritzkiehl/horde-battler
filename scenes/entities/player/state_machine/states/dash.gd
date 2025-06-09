extends State

@export
var dash_duration: float = 0.25

@export
var attack_state: State
@export
var return_state: State


var dashing:bool = false
var timer: Timer

func enter() -> void:
	print(parent)
	start_dash()
	parent.animations.play(animation_name)
	
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('attack'):
		return attack_state
	return null

func process_physics(delta: float) -> State:	

	if dashing:
		if parent.direction == Vector2.LEFT:
			parent.velocity.x = move_speed * Vector2.LEFT.x
		if parent.direction == Vector2.RIGHT:
			parent.velocity.x = move_speed * Vector2.RIGHT.x
		if parent.direction == Vector2.UP:
			parent.velocity.y = move_speed * Vector2.UP.y
		if parent.direction == Vector2.DOWN:
			parent.velocity.y = move_speed * Vector2.DOWN.y
		parent.move_and_slide()
		return null
	else: 
		return return_state
			
func start_dash() -> void:
	print('Start Dash')
	dashing = true
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true	
	timer.autostart = false
	timer.start(dash_duration)
	timer.timeout.connect(end_dash)
	
func end_dash() -> void:
	dashing = false
	print('End Dash')
