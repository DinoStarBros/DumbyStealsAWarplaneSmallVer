extends Node2D
## Component for projectiles that handles the li'l
## Juice hit effect when a projecile hits an enemy or smthn
class_name ProjectileOnHitFXComponent

@export var fx_scn : PackedScene

func _ready() -> void:
	pass

func hit() -> void:
	_spawn_projectile_fx()

func _spawn_projectile_fx() -> void:
	var fx : ProjectileHitFX = fx_scn.instantiate()
	
	fx.global_position = global_position
	g.game.add_child(fx)
