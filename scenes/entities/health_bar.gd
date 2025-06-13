class_name HealthBar extends ProgressBar

var character: Entity2D

func initHealtBar(parent_instance: Entity2D) -> void:
	character = parent_instance
	max_value = parent_instance.get_max_health()
	value = parent_instance.get_current_health()
	min_value = 0
	
func update() -> void:
	value = character.get_current_health()
	if value != max_value:
		self.visible = true
		if value == min_value:
			self.visible = false
	else:
		self.visible = false
