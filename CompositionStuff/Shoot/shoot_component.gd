extends Node2D
class_name ShootComponent

var parent_weapon : Weapon
var stats : WeaponStats
var p : Dumby

var can_shoot : bool = false
var cooldown : float
var rand_spread_vector : Vector2
var dir_to_mouse : Vector2

func _ready() -> void:
	parent_weapon = get_parent()
	stats = parent_weapon.stats
	
	await get_tree().process_frame
	p = parent_weapon.p

func _process(delta: float) -> void:
	if parent_weapon.p.weapons_parent.current_weapon != parent_weapon:
		return
	
	shooting_handling(delta)

func shooting_handling(delta:float) -> void:
	if p.shooting and can_shoot:
		parent_weapon.play_sfx()
		
		parent_weapon.ammo -= stats.ammo_use
		p.Shoot.emit()
		
		can_shoot = false
		cooldown = stats.shoot_cooldown
		
		for n in stats.bullet_amnt:
			parent_weapon.play_multi_sfx()
			spawn_bullet()
			await get_tree().create_timer(stats.shoot_delay).timeout
	
	# Handling for the shooting cooldown
	can_shoot = cooldown <= 0 # U can shoot once cooldown is less than 0
	cooldown = max(0, cooldown - delta) # Reduces the cooldown, also limit to not be less than 0

func spawn_bullet() -> void:
	rand_spread_vector.x = randf_range(-stats.random_spread, stats.random_spread)
	rand_spread_vector.y = randf_range(-stats.random_spread, stats.random_spread)
	
	var projectile : Projectile = stats.bullet_scn.instantiate()
	g.game.add_child(projectile)
	
	dir_to_mouse = p.dir_plane # The direction of the plane, not directly the mouse
	
	projectile.dmg = stats.base_damage * (1.0 + PlayerStats.percent_damage)
	
	projectile.global_position = global_position + (dir_to_mouse * 50)
	projectile.velocity = (dir_to_mouse + rand_spread_vector) * stats.bullet_spd
	projectile.look_at(projectile.global_position + projectile.velocity)
	projectile.lifetime = stats.bullet_lifetime
