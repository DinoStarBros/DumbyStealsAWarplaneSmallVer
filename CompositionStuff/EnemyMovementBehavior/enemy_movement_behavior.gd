extends Node2D
class_name EnemyMovementBehavior

@export var velocity_component : VelocityComponent
@export var rotation_component : RotationComponent

@onready var pursuit_behavior: PursuitBehavior = %PursuitBehavior

enum BEHAVIOR_TYPE {
	PURSUIT, DISTANCE
}
var current_behavior_type : BEHAVIOR_TYPE

func _physics_process(delta: float) -> void:
	match current_behavior_type:
		BEHAVIOR_TYPE.PURSUIT:
			do_pursuit(delta)
		BEHAVIOR_TYPE.DISTANCE:
			do_distance(delta)
		_:
			do_pursuit(delta)

func do_pursuit(delta: float) -> void:
	pursuit_behavior.behave(delta)

func do_distance(delta: float) -> void:
	pass
