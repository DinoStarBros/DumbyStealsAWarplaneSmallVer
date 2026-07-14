extends Line2D
class_name TrailFX

@export var MAX_LENGTH : float = 20 ## Length of the trail line

var pos : Vector2
var queue : Array
var enable : bool = true ## Decides if it will start plotting points or nah
var player_mode : bool = true

func _physics_process(delta: float) -> void:
	
	pos = _get_position()
	
	queue.push_front(pos)
	
	if queue.size() > MAX_LENGTH:
		queue.pop_back()
	
	clear_points()
	
	for point : Vector2 in queue:
		add_point(point)

func _get_position() -> Vector2:
	if get_parent() is Node2D:
		return get_parent().global_position
	else:
		return get_global_mouse_position()
