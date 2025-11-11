extends Node2D
## Component that handles which stats will be improved when getting a buff. 
## This code is fucking outrageous to look at there hass to be a better way to do this.
class_name WeaponBuffComponent

@onready var parent_weapon : Weapon = get_parent()
var stats : WeaponStats

#@export var shoot_component : ShootComponent

var current_shoot_cooldown_buff : float = 0.0 
var current_bullet_spd_buff : float
var current_bullet_amnt_buff : int
var current_random_spread_buff : float
var current_bullet_lifetime_buff : float = 1.0
var current_shoot_delay_buff : float 
var current_damage_buff : float
var current_max_ammo_buff : float ## Not sure if I'll be using this shit. DUMBASS
var current_ammo_use_buff : int

func _ready() -> void:
	stats = parent_weapon.stats

func _process(delta: float) -> void:
	# This some Yandere Dev coding type shii
	var qr_buffed : bool = parent_weapon.p.weapons_parent.q_reload_buffed
	var db_buffed : bool = parent_weapon.p.weapons_parent.dodge_buffed
	
	if qr_buffed and !db_buffed:
		# Stats getting improved when quick reload buffed
		
		current_shoot_cooldown_buff = 1 + stats.qr_shoot_cooldown
		current_bullet_spd_buff = 1 + stats.qr_bullet_spd
		current_bullet_amnt_buff = stats.qr_bullet_amnt
		current_random_spread_buff = stats.qr_random_spread
		current_bullet_lifetime_buff = stats.qr_bullet_lifetime
		current_shoot_delay_buff = stats.qr_shoot_delay
		current_damage_buff = 1 + stats.qr_damage
		#current_max_ammo_buff  
		current_ammo_use_buff = stats.qr_ammo_use
		
	if db_buffed and !qr_buffed:
		# Stats getting improved when dodge buffed
		
		current_shoot_cooldown_buff = 1 + stats.db_shoot_cooldown
		current_bullet_spd_buff = 1 + stats.db_bullet_spd
		current_bullet_amnt_buff = stats.db_bullet_amnt
		current_random_spread_buff = stats.db_random_spread
		current_bullet_lifetime_buff = stats.db_bullet_lifetime
		current_shoot_delay_buff = stats.db_shoot_delay
		current_damage_buff = 1 + stats.db_damage
		#current_max_ammo_buff 
		current_ammo_use_buff = stats.db_ammo_use
		
	if db_buffed and qr_buffed:
		# Stats getting improved when getting both quick reload & dodge buff
		
		current_shoot_cooldown_buff = 1 + stats.qr_shoot_cooldown + stats.db_shoot_cooldown
		current_bullet_spd_buff = 1 + stats.qr_bullet_spd + stats.db_bullet_spd
		current_bullet_amnt_buff = stats.qr_bullet_amnt + stats.db_bullet_amnt
		current_random_spread_buff = stats.qr_random_spread + stats.db_random_spread
		current_bullet_lifetime_buff = stats.qr_bullet_lifetime + stats.db_bullet_lifetime
		current_shoot_delay_buff = stats.qr_shoot_delay + stats.db_shoot_delay
		current_damage_buff = 1 + stats.qr_damage + stats.db_damage
		#current_max_ammo_buff
		current_ammo_use_buff = stats.qr_ammo_use + stats.db_ammo_use
		
	if !db_buffed and !qr_buffed:
		# Not buffed, no stat improvement
		
		current_shoot_cooldown_buff = 1
		current_bullet_spd_buff = 1
		current_bullet_amnt_buff = 0
		current_random_spread_buff = 1
		current_bullet_lifetime_buff = 0
		current_shoot_delay_buff = 0
		current_damage_buff = 1
		#current_max_ammo_buff  
		current_ammo_use_buff = 0
