extends Node2D
class_name EnemyShootBehavior

@export var shoot_component : EnemyShootComponent

@onready var constant_behavior: ConstantBehavior = %ConstantBehavior

enum BEHAVIOR_TYPE {
	NO_SHOOT, CONSTANT
}
var current_behavior_type : BEHAVIOR_TYPE

func _physics_process(delta: float) -> void:
	match current_behavior_type:
		BEHAVIOR_TYPE.CONSTANT:
			do_constant(delta)

func do_constant(delta: float) -> void:
	constant_behavior.behave(delta)
