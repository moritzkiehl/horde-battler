extends Entity2D

func _ready() -> void:
	super._ready()


func _on_hitbox_body_entered(body: Node2D) -> void:
	print('Body of type ' + body.name + ' entered')
