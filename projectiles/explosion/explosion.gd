extends Projectile
class_name Explosion

func _ready() -> void:
	rotation_degrees = randf_range(-180,180)
	scale.x += randf_range(0.1, 0.2)
	scale.y = scale.x

func _process(delta: float) -> void:
	pass
