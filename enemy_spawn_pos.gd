extends Path2D
## Handles spwaning enemies & waves for the sky
class_name EnemySpawnerSky

@export var enemy_spawn_pos: PathFollow2D
@export var waves  : Array[Wave]
@export var spawn_timer : Timer
@export var boss_timer : Timer
var wave : Wave
var spawn_time : float

func _ready() -> void:
	g.wave = 1
	wave_start()
	GlobalSignals.Upgrade_End.connect(_on_upgrade_end)
	
	boss_timer.timeout.connect(_on_boss_timer_timeout)

func wave_start() -> void:
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
					spawn_enemy()
					wave.spawn_budget -= 1
	
	update_spawn_budget_text()

func spawn_enemy()->void:
	var enemy_scn : PackedScene = wave.enemies.pick_random()
	var enemy : CharacterBody2D = enemy_scn.instantiate()
	
	enemy_spawn_pos.progress_ratio = randf()
	enemy.global_position = enemy_spawn_pos.global_position
	g.enemy_container.add_child(enemy)

func update_spawn_budget_text() -> void:
	g.spawn_budget = Vector2(wave.spawn_budget, wave.max_spawn_budget)

func spawn_boss(bwave: BossWave) -> void:
	var boss : CharacterBody2D = bwave.boss_scn.instantiate()
	
	enemy_spawn_pos.progress_ratio = randf()
	boss.global_position = enemy_spawn_pos.global_position
	g.game.add_child(boss)

func _process(_delta: float) -> void:
	if wave is EnemyWave:
		enemy_wave_end_handling()
	elif wave is BossWave:
		boss_wave_end_handling()

func _on_upgrade_end() -> void:
	g.wave += 1
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
	spawn_boss(wave)
