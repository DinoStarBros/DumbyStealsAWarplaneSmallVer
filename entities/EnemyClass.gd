extends CharacterBody2D
class_name Enemy ## Base class for enemies

@export var enemy_stats_allocator : EnemyStatsAllocator

var enemy_stat_res : EnemyStats:
	set(value):
		enemy_stat_res = value
		enemy_stats_allocator.stats = enemy_stat_res

func damage(attack: Attack) -> void:
	pass

func Dead(attack: Attack) -> void:
	pass
