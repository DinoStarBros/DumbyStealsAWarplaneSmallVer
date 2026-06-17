extends Node2D
class_name EnemyShootBehavior

@export var shoot_component : EnemyShootComponent

enum BEHAVIOR_TYPE {
	NO_SHOOT, CONSTANT
}
var current_behavior_type : BEHAVIOR_TYPE

func _physics_process(delta: float) -> void:
	match current_behavior_type:
		BEHAVIOR_TYPE.NO_SHOOT:
			
		BEHAVIOR_TYPE.CONSTANT:
			
		_:
			

func do_no_shoot(delta: float) -> void:
	pass
