extends Node2D
class_name EnemyShootComponent

var projectile_scn : PackedScene
var projectile_dmg : float = 5.0
var speed : float = 500.0
var lifetime : float = 1.0
var min_shoot_cooldown : float = 5.0
var max_shoot_cooldown : float = 5.0

var shoot_cd : float = 0

func _process(delta: float) -> void:
	pass

func shoot() -> void:
	pass
