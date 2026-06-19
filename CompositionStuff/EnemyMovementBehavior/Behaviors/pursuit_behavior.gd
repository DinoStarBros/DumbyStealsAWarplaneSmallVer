extends MovementBehavior
class_name PursuitBehavior

var target : Dumby
var dist_to_target : float
var target_position : Vector2
var target_deviation : Vector2
var dir_to_target : Vector2

const TARGET_DEVIATION_RANGE : float = 500.0

func _ready() -> void:
	target_deviation.x = randf_range(-TARGET_DEVIATION_RANGE,TARGET_DEVIATION_RANGE)
	target_deviation.y = randf_range(-TARGET_DEVIATION_RANGE,TARGET_DEVIATION_RANGE)

func behave(delta: float) -> void:
	target = g.player
	
	dist_to_target = global_position.distance_to(target.global_position)
	if dist_to_target >= TARGET_DEVIATION_RANGE + (TARGET_DEVIATION_RANGE/5.0):
		target_position = target.global_position + target_deviation
		dir_to_target = ((target_position) - global_position).normalized()
	else:
		target_position = target.global_position
		dir_to_target = (target_position - global_position).normalized()
	
	parent.rotation_component.plane_rotation_handling(delta, target_position)
	parent.rotation_component.plane_rotation_handling(delta, target_position)
	parent.velocity_component.other_velocity_handle(delta, parent.rotation_component.direction, true)
