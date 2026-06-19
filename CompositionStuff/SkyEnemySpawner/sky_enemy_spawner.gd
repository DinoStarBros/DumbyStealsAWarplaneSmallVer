extends Path2D

@onready var path_follow: PathFollow2D = %PathFollow
@onready var spawn_timer: Timer = %SpawnTimer

const SPAWN_TIME_INTERVAL_CHANGE : float = 0.05
const GENERIC_ENEMY_SCN : PackedScene = preload("res://entities/GenericEnemy/generic_enemy.tscn")
const ENEMY_STATS_RES : Array[EnemyStats] = [
	preload("res://resources/enemy_stats/Chaser.tres"),
	preload("res://resources/enemy_stats/Shooter.tres"),
	preload("res://resources/enemy_stats/Shotgunner.tres"),
	preload("res://resources/enemy_stats/SpikeBall.tres"),
	#preload("res://resources/enemy_stats/Bruh.tres"),
	
]

var current_spawn_interval : float = 3.0

func _ready() -> void:
	spawn_timer.timeout.connect(_spawn_timer_timeout)

func spawn_enemy() -> void:
	# Game state has to be Combat
	if g.game_state != g.game_states.Combat:
		return
	
	global_position = g.player.global_position
	path_follow.progress_ratio = randf()
	
	var enemy : Enemy = GENERIC_ENEMY_SCN.instantiate()
	
	enemy.enemy_stat_res = ENEMY_STATS_RES.pick_random()
	
	g.enemy_container.add_child(enemy)
	
	enemy.global_position = path_follow.global_position

func _spawn_timer_timeout() -> void:
	spawn_enemy()
	current_spawn_interval = max(0.1, current_spawn_interval - SPAWN_TIME_INTERVAL_CHANGE)
	spawn_timer.start(current_spawn_interval)
