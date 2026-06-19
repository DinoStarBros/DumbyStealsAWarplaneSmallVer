extends ShootBehavior
class_name ConstantBehavior

@onready var parent : EnemyShootBehaviorComponent = get_parent()

func behave(delta: float) -> void:
	parent.shoot_component.shooting = true
