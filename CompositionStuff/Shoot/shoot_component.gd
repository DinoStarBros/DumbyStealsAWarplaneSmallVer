extends Node2D
class_name ShootComponent

var parent_weapon : Weapon
var stats : WeaponStats
var p : Dumby

func _ready() -> void:
	parent_weapon = get_parent()
	stats = parent_weapon.stats
	p = owner

func _process(delta: float) -> void:
	if parent_weapon.p.weapons_parent.current_weapon != self:
		return
	
	#shooting_handling(delta)
#
#func shooting_handling(delta:float) -> void:
	#if p.shooting and parent_weapon.can_shoot:
		#play_sfx()
		#p.Shoot.emit()
		#
		#cooldown = stats.shoot_cooldown
		#
		#for n in stats.bullet_amnt:
			#spawn_bullet()
			#await get_tree().create_timer(stats.shoot_delay).timeout
	#
	## Handling for the shooting cooldown
	#can_shoot = cooldown <= 0 # U can shoot once cooldown is less than 0
	#cooldown = max(0, cooldown - delta) # Reduces the cooldown, also limit to not be less than 0
#
#func spawn_bullet() -> void:
	#ammo -= stats.ammo_use
	#
	#rand_spread_vector.x = randf_range(-stats.random_spread, stats.random_spread)
	#rand_spread_vector.y = randf_range(-stats.random_spread, stats.random_spread)
	#
	#var bullet : Projectile = stats.bullet_scn.instantiate()
	#g.game.add_child(bullet)
	#
	#dir_to_mouse = p.dir_plane # The direction of the plane, not directly the mouse
	#
	#bullet.dmg = stats.base_damage * (1.0 + PlayerStats.percent_damage)
	#
	#bullet.global_position = global_position + (dir_to_mouse * 50)
	#bullet.velocity = (dir_to_mouse + rand_spread_vector) * stats.bullet_spd
	#bullet.look_at(bullet.global_position + bullet.velocity)
	#bullet.lifetime = stats.bullet_lifetime
