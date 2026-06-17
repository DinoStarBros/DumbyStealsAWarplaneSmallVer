extends Path2D

@onready var path_follow: PathFollow2D = %PathFollow
@onready var spawn_timer: Timer = %SpawnTimer

const generic_enemy_scn : PackedScene = preload("res://entities/GenericEnemy/generic_enemy.tscn")
const enemy_stats_res : Array[EnemyStats] = [
	preload("res://resources/enemy_stats/Chaser.tres"),
	preload("res://resources/enemy_stats/Shooter.tres"),
	preload("res://resources/enemy_stats/Shotgunner.tres"),
	preload("res://resources/enemy_stats/SpikeBall.tres"),
	
]

func _ready() -> void:
	spawn_timer.timeout.connect(_spawn_timer_timeout)

func spawn_enemy() -> void:
	global_position = g.player.global_position
	path_follow.progress_ratio = randf()
	
	var enemy : Enemy = generic_enemy_scn.instantiate()
	
	enemy.enemy_stat_res = enemy_stats_res[0]
	
	g.enemy_container.add_child(enemy)
	
	enemy.global_position = path_follow.global_position

func _spawn_timer_timeout() -> void:
	spawn_enemy()
