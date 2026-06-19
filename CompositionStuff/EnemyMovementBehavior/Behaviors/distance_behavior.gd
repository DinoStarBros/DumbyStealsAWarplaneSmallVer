extends MovementBehavior
class_name DistanceBehavior

var target : Dumby
var dist_to_target : float
var target_position : Vector2
var target_deviation : Vector2
var dir_to_target : Vector2
var dir_to_target_deviate_pos : Vector2

const TARGET_DEVIATION_RANGE : float = 500.0

func _ready() -> void:
	target_deviation.x = randf_range(-TARGET_DEVIATION_RANGE,TARGET_DEVIATION_RANGE)
	target_deviation.y = randf_range(-TARGET_DEVIATION_RANGE,TARGET_DEVIATION_RANGE)

func behave(delta: float) -> void:
	target = g.player
	dir_to_target = (target.global_position - global_position).normalized()
	
	dir_to_target_deviate_pos = global_position.direction_to(target.global_position + target_deviation)
	parent.rotation_component.plane_rotation_handling(delta, target.global_position)
	#direction = parent.rotation_component.direction
	parent.velocity_component.other_velocity_handle(delta, dir_to_target_deviate_pos, true)
