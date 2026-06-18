extends Node2D
class_name ConstantBehavior

@onready var parent : EnemyShootBehavior = get_parent()

func behave(delta: float) -> void:
	parent.shoot_component.shooting = true
