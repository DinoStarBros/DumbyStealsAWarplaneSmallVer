extends Node2D
class_name BossSpawnHandlerSky

@onready var enemy_spawn_pos: PathFollow2D = %enemySpawnPos

func spawn_boss(bwave: BossWave) -> void:
	var boss : CharacterBody2D = bwave.boss_scn.instantiate()
	
	enemy_spawn_pos.progress_ratio = randf()
	boss.global_position = enemy_spawn_pos.global_position
	g.game.add_child(boss)
	
	GlobalSignals.Boss_Spawned.emit()
