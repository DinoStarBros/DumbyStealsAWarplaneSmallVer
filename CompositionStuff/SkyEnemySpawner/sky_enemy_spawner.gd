extends Path2D

@onready var path_follow: PathFollow2D = %PathFollow

var enemy_scns : Array[PackedScene] = [
	
]

func spawn_enemy() -> void:
	path_follow.progress_ratio = randf()
	var enemy : Enemy
	
