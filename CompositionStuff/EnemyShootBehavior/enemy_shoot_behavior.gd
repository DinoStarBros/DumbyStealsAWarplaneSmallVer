extends Node2D
class_name EnemyShootBehaviorComponent

@export var shoot_component : EnemyShootComponent

@onready var constant_behavior: ConstantBehavior = %ConstantBehavior

enum BEHAVIOR_TYPE {
	NO_SHOOT, CONSTANT, SNIPE, UP_CLOSE
}
var current_behavior_type : BEHAVIOR_TYPE

func _physics_process(delta: float) -> void:
	match current_behavior_type:
		BEHAVIOR_TYPE.CONSTANT:
			do_constant(delta)
		BEHAVIOR_TYPE.SNIPE:
			do_snipe(delta)
		BEHAVIOR_TYPE.UP_CLOSE:
			do_up_close(delta)

func do_constant(delta: float) -> void:
	constant_behavior.behave(delta)

func do_snipe(delta: float) -> void:
	pass

func do_up_close(delta: float) -> void:
	pass
