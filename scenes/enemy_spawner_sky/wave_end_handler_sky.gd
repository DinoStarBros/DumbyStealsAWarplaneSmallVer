extends Node2D
class_name WaveEndHandlerSky

@onready var spawn_timer: Timer = %spawnTimer

func _init() -> void:
	# Signal Connections
	GlobalSignals.Boss_Defeated.connect(_on_boss_defeated)

func enemy_wave_end_handling(wave: EnemyWave) -> void:
	if not wave.spawn_budget <= 0:
		return
		# Checks if all enemies from the budget have spawned
		# If so, allow wave ending
	
	if g.game_state == g.game_states.Lost:
		return
		# Prevents the upgrade phase from starting if u die
	
	if g.enemy_container.get_children().size() <= 0 and g.game_state == g.game_states.Combat:
		spawn_timer.stop()
		GlobalSignals.Wave_End.emit()

func boss_wave_end_handling() -> void:
	pass

func _on_boss_defeated(boss_pos: Vector2, cd: float) -> void:
	if g.game_state == g.game_states.Lost:
		return
		# Prevents the upgrade phase from starting if u die
	
	spawn_timer.stop()
	await get_tree().create_timer(cd).timeout
	GlobalSignals.Wave_End.emit()
