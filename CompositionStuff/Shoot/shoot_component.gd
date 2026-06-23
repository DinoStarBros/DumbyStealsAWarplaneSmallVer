extends Node2D
class_name ShootComponent

@export var weapon_buff : WeaponBuffComponent
@export var parent_weapon : Weapon

var stats : WeaponStats
var p : Dumby

var can_shoot : bool = false
var cooldown : float
var rand_spread_vector : Vector2
var dir_to_mouse : Vector2

func _ready() -> void:
	stats = parent_weapon.weapon_stat_res
	
	await get_tree().process_frame
	p = g.player

func _process(delta: float) -> void:
	
	var current_weapon : Weapon = p.weapons_parent.current_weapon
	if current_weapon != parent_weapon:
		return
	
	shooting_handling(delta)

func shooting_handling(delta:float) -> void:
	if p.shooting and can_shoot:
		parent_weapon.play_single_sfx()
		parent_weapon.play_muzzle_flash()
		
		p.Shoot.emit()
		
		can_shoot = false
		cooldown = stats.shoot_cooldown
		
		for n in stats.bullet_amnt + weapon_buff.current_bullet_amnt_buff:
			parent_weapon.play_multi_sfx()
			spawn_bullet()
			
			var sdelay : float = stats.shoot_delay - (stats.shoot_delay * weapon_buff.current_shoot_delay_buff)
			
			if sdelay > 0.0:
				await get_tree().create_timer(sdelay).timeout 
	
	# Handling for the shooting cooldown
	can_shoot = cooldown <= 0 # U can shoot once cooldown is less than 0
	cooldown = max(0, cooldown - (delta * weapon_buff.current_shoot_cooldown_buff))

func spawn_bullet() -> void:
	rand_spread_vector.x = randf_range(-stats.random_spread, stats.random_spread)
	rand_spread_vector.y = randf_range(-stats.random_spread, stats.random_spread)
	
	rand_spread_vector -= rand_spread_vector * weapon_buff.current_random_spread_buff
	
	rand_spread_vector.x = max(0, rand_spread_vector.x) # Disallows it from going negative
	rand_spread_vector.y = max(0, rand_spread_vector.y) 
	
	var projectile : Projectile = stats.bullet_scn.instantiate()
	projectile.lifetime = stats.bullet_lifetime + weapon_buff.current_bullet_lifetime_buff
	
	projectile.dmg = stats.base_damage * (1.0 + PlayerStats.percent_damage) * weapon_buff.current_damage_buff
	projectile.current_team = HitboxComponent.TEAM.PLAYER
	
	g.world.add_child(projectile)
	
	dir_to_mouse = p.dir_plane # The direction of the plane, not directly the mouse
	
	projectile.global_position = global_position + (dir_to_mouse * 50)
	projectile.velocity = (dir_to_mouse + rand_spread_vector) * stats.bullet_spd * weapon_buff.current_bullet_spd_buff
	projectile.look_at(projectile.global_position + projectile.velocity)
