extends ProgressBar

var parent
var max_health_value
var min_health_value

func _ready() -> void:
	parent = get_parent()
	self.max_value = parent.health_max
	max_health_value = max_value
	min_health_value = parent.health_min

func _process(delta: float) -> void:
	self.value = parent.health
	if parent.health != max_health_value:
		self.visible = true
		if parent.health == min_health_value:
			self.visible = false
	else:
		self.visible = false
