extends Node2D
## Component that handles which weapon stats will be improved when getting a buff. 
## This code is fucking outrageous to look at lol.
class_name WeaponBuffComponent

@export var parent_weapon : Weapon

var weapon_stats : WeaponStats
var p : Dumby

var current_shoot_cooldown_buff : float = 0.0
var current_bullet_spd_buff : float
var current_bullet_amnt_buff : int
var current_random_spread_buff : float
var current_bullet_lifetime_buff : float = 1.0
var current_shoot_delay_buff : float
var current_damage_buff : float

func _ready() -> void:
	
	await get_tree().process_frame
	p = g.player
	weapon_stats = parent_weapon.weapon_stat_res

func _process(delta: float) -> void:
	# This some Yandere Dev coding type shii
	var buffed : bool = false#p.weapons_parent.dodge_buffed
	
	if buffed:
		# Stats getting improved when buffed
		
		current_shoot_cooldown_buff = 1 + weapon_stats.shoot_cooldown_buff
		current_bullet_spd_buff = 1 + weapon_stats.bullet_spd_buff
		current_bullet_amnt_buff = weapon_stats.bullet_amnt_buff
		current_random_spread_buff = weapon_stats.random_spread_buff
		current_bullet_lifetime_buff = weapon_stats.bullet_lifetime_buff
		current_shoot_delay_buff = weapon_stats.shoot_delay_buff
		current_damage_buff = 1 + weapon_stats.damage_buff
		
