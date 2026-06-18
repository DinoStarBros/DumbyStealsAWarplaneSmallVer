extends Node2D
class_name EnemyMovementBehavior

@export var velocity_component : VelocityComponent
@export var rotation_component : RotationComponent

@onready var pursuit_behavior: PursuitBehavior = %PursuitBehavior
@onready var distance_behavior: DistanceBehavior = %DistanceBehavior
@onready var direct_chase_behavior: DirectChaseBehavior = %DirectChaseBehavior

enum BEHAVIOR_TYPE {
	PURSUIT, DISTANCE, DIRECT_CHASE
}
var current_behavior_type : BEHAVIOR_TYPE

func _physics_process(delta: float) -> void:
	match current_behavior_type:
		BEHAVIOR_TYPE.PURSUIT:
			do_pursuit(delta)
		BEHAVIOR_TYPE.DISTANCE:
			do_distance(delta)
		BEHAVIOR_TYPE.DIRECT_CHASE:
			do_direct_chase(delta)
		_:
			do_pursuit(delta)

func do_pursuit(delta: float) -> void:
	pursuit_behavior.behave(delta)

func do_distance(delta: float) -> void:
	distance_behavior.behave(delta)

func do_direct_chase(delta: float) -> void:
	direct_chase_behavior.behave(delta)
