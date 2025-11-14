extends Path2D
## Handles spwaning enemies & waves for the sky
class_name EnemySpawnerSky

@export var waves  : Array[Wave]

@onready var spawn_timer: Timer = %spawnTimer
@onready var boss_timer: Timer = %bossTimer
@onready var enemy_spawn_handler: EnemySpawnHandlerSky = %enemySpawnHandler
@onready var boss_spawn_handler: BossSpawnHandlerSky = %bossSpawnHandler

var wave : Wave
var spawn_time : float

func _ready() -> void:
	g.wave = 0
	wave_start()
	
	# Signal Connections
	GlobalSignals.Upgrade_End.connect(_on_upgrade_end)
	boss_timer.timeout.connect(_on_boss_timer_timeout)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

func wave_start() -> void:
	g.wave += 1
	wave = waves[g.wave - 1]
	
	if wave is EnemyWave:
		spawn_time = wave.starting_spawn_time
		spawn_timer.start(spawn_time)
		wave.spawn_budget = wave.max_spawn_budget
		update_spawn_budget_text()
	if wave is BossWave:
		boss_timer.start(1)

func _on_spawn_timer_timeout() -> void:
	spawn_time -= wave.spawn_time_increment
	if spawn_time <= wave.minimum_spawn_time:
		spawn_time = wave.minimum_spawn_time
	spawn_timer.start(spawn_time)
	
	if get_tree().get_nodes_in_group("Enemy").size() <= wave.enemy_limit and g.game_state == g.game_states.Combat:
			for n in randi_range(wave.min_enemy_amount, wave.max_enemy_amount):
				if wave.spawn_budget >= 1:
					enemy_spawn_handler.spawn_enemy(wave)
					wave.spawn_budget -= 1
	
	update_spawn_budget_text()

func _process(_delta: float) -> void:
	if wave is EnemyWave:
		enemy_wave_end_handling()
	elif wave is BossWave:
		boss_wave_end_handling()

func _on_upgrade_end() -> void:
	wave_start()

func enemy_wave_end_handling() -> void:
	if not wave.spawn_budget <= 0:
		return
		# Checks if all enemies from the budget have spawned
		# If so, allow wave ending
	
	if g.game_state == g.game_states.Lost:
		return
		# Prevents the upgrade phase from starting if u die
	
	if g.enemy_container.get_children().size() <= 0 and g.game_state == g.game_states.Combat:
		GlobalSignals.Wave_End.emit()
		spawn_timer.stop()

func boss_wave_end_handling() -> void:
	pass

func _on_boss_timer_timeout() -> void:
	boss_spawn_handler.spawn_boss(wave)

func update_spawn_budget_text() -> void:
	g.spawn_budget = Vector2(wave.spawn_budget, wave.max_spawn_budget)
