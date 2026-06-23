extends Node2D
class_name World

@export var sky_enemy_spawner : SkyEnemySpawner

var level_resource_to_load : LevelEnemySpawns

func load_level() -> void:
	level_resource_to_load = g.level_resource_to_load
	sky_enemy_spawner.level_resource = level_resource_to_load
	g.level_resource_to_load = null
