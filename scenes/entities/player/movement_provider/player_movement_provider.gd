class_name PlayerMovementProvider extends MovementProvider


func get_movement_vector() -> Vector2:
	var move_left = Input.get_action_strength("move_left")
	var move_right = Input.get_action_strength("move_right")
	var move_up = Input.get_action_strength("move_up")
	var move_down = Input.get_action_strength("move_down")
		
	if move_left != 0 || move_right != 0 || move_up != 0 || move_down != 0:
		moving = true
		if move_right != 0:
			latest_directionX = 1
		elif move_left != 0:
			latest_directionX = -1
		else:
			latest_directionX = 0

		if move_up != 0:
			latest_directionY = -1
		elif move_down != 0:
			latest_directionY = 1
		else:
			latest_directionY = 0
			
		direction.x = latest_directionX
		direction.y = latest_directionY
		return direction
	else:
		moving = false
		return Vector2(0,0)

	
