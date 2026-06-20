extends Projectile
class_name OrbitBall

var desire_position : Vector2
var direction_to_desire_position : Vector2
var circle : Vector2
var time_elapsed : float
var current_orbit_distance : float = 0
var desire_orbit_distance : float = 0
var orbit_speed : float = 4
var random_start : float = randf_range(-1, 1)

const SNAP_SPEED : float = 1000
const BASE_ORBIT_DISTANCE : float = 200
const BUFFED_ORBIT_DISTANCE : float = 300
const BASE_ORBIT_SPEED : float = 5
const BUFFED_ORBIT_SPEED : float = 8

func _physics_process(delta: float) -> void:
	lifetime_handle(delta)
	move(delta)
	orbit_handle(delta)

func orbit_handle(delta: float) -> void:
	time_elapsed += delta * orbit_speed
	
	circle.x = cos(time_elapsed + random_start)
	circle.y = sin(time_elapsed + random_start)
	
	desire_position = g.player.global_position + (circle * current_orbit_distance)
	direction_to_desire_position = global_position.direction_to(desire_position)
	
	#velocity = lerp(
		#velocity,
		#direction_to_desire_position * SNAP_SPEED,
		#20.0 * delta
		#)
	#velocity = direction_to_desire_position * SNAP_SPEED
	global_position = desire_position
	
	if g.player.weapons_parent.buff_time > 0:
		desire_orbit_distance = BUFFED_ORBIT_DISTANCE
		orbit_speed = BUFFED_ORBIT_SPEED
	else:
		desire_orbit_distance = BASE_ORBIT_DISTANCE
		orbit_speed = BASE_ORBIT_SPEED
	
	current_orbit_distance = lerp(current_orbit_distance, desire_orbit_distance, 12.0 * delta)
