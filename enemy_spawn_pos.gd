extends Path2D
class_name EnemySpawnerSky

@export var waves  : Array[Wave]
var wave : Wave
var spawn_time : float

func _ready() -> void:
	g.wave = 1
	wave_start()
	GlobalSignals.Upgrade_End.connect(_on_upgrade_end)

func wave_start() -> void:
	wave = waves[g.wave - 1]
	
	spawn_time = wave.starting_spawn_time
	%spawnTimer.start(spawn_time)
	wave.spawn_budget = wave.max_spawn_budget
	
	update_spawn_budget_text()

func _on_spawn_timer_timeout() -> void:
	spawn_time -= wave.spawn_time_increment
	if spawn_time <= wave.minimum_spawn_time:
		spawn_time = wave.minimum_spawn_time
	%spawnTimer.start(spawn_time)
	
	if get_tree().get_nodes_in_group("Enemy").size() <= wave.enemy_limit and g.game_state == g.game_states.Combat:
			for n in randi_range(wave.min_enemy_amount, wave.max_enemy_amount):
				if wave.spawn_budget >= 1:
					spawn_enemy()
					wave.spawn_budget -= 1
	
	update_spawn_budget_text()

func spawn_enemy()->void:
	var enemy_scn : PackedScene = wave.enemies.pick_random()
	var enemy : CharacterBody2D = enemy_scn.instantiate()
	
	%enemy_spawn_pos.progress_ratio = randf()
	enemy.global_position = %enemy_spawn_pos.global_position
	g.enemy_container.add_child(enemy)

func update_spawn_budget_text() -> void:
	g.spawn_budget = Vector2(wave.spawn_budget, wave.max_spawn_budget)

func _process(_delta: float) -> void:
	#print(g.gs_string)
	
	if not wave.spawn_budget <= 0:
		# Checks if all enemies from the budget have spawned
		# If so, allow wave ending
		return
	
	if g.game_state == g.game_states.Lost:
		# Prevents the upgrade phase from starting if u die
		return
	
	if g.enemy_container.get_children().size() <= 0 and g.game_state == g.game_states.Combat:
		GlobalSignals.Wave_End.emit()

func _on_upgrade_end() -> void:
	g.wave += 1
	wave_start()
