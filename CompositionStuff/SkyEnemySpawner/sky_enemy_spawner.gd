extends Path2D

@onready var path_follow: PathFollow2D = %PathFollow
@onready var spawn_timer: Timer = %SpawnTimer

const SPAWN_TIME_INTERVAL_CHANGE : float = 0.05
const GENERIC_ENEMY_SCN : PackedScene = preload("res://entities/GenericEnemy/generic_enemy.tscn")

var level_resource : LevelEnemySpawns = preload("res://resources/LevelResources/1-1.tres")
var current_spawn_interval : float = 3.0

func _ready() -> void:
	current_spawn_interval = level_resource.starting_spawn_time
	spawn_timer.timeout.connect(_spawn_timer_timeout)

func spawn_enemy() -> void:
	# Game state has to be Combat
	if g.game_state != g.game_states.Combat:
		return
	
	global_position = g.player.global_position
	path_follow.progress_ratio = randf()
	
	var enemy : Enemy = GENERIC_ENEMY_SCN.instantiate()
	
	enemy.enemy_stat_res = level_resource.enemies.pick_random()
	
	g.enemy_container.add_child(enemy)
	
	enemy.global_position = path_follow.global_position

func _spawn_timer_timeout() -> void:
	var enemy_spawn_amnt : int = randi_range(
		level_resource.min_enemy_spawn_amount,
		level_resource.max_enemy_spawn_amount
	)
	for enemy in enemy_spawn_amnt:
		spawn_enemy()
	
	current_spawn_interval = max(level_resource.minimum_spawn_time, current_spawn_interval - level_resource.spawn_time_increment)
	spawn_timer.start(current_spawn_interval)
