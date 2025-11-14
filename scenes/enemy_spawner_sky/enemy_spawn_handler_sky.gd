extends Node2D
class_name EnemySpawnHandlerSky

@onready var enemy_spawn_pos: PathFollow2D = %enemySpawnPos

func spawn_enemy(ewave: EnemyWave)->void:
	var enemy_scn : PackedScene = ewave.enemies.pick_random()
	var enemy : CharacterBody2D = enemy_scn.instantiate()
	
	enemy_spawn_pos.progress_ratio = randf()
	enemy.global_position = enemy_spawn_pos.global_position
	g.enemy_container.add_child(enemy)
