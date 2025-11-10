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
var current_ammo_use_buff : float

func _ready() -> void:
	stats = parent_weapon.stats

func _process(delta: float) -> void:
	if parent_weapon.p.weapons_parent.q_reload_buffed:
		# Stats getting improved when quick reload buffed
		
		current_shoot_cooldown_buff = 1 + stats.qr_shoot_cooldown
		current_bullet_spd_buff 
		current_bullet_amnt_buff 
		current_random_spread_buff 
		current_bullet_lifetime_buff
		current_shoot_delay_buff  
		current_damage_buff 
		#current_max_ammo_buff  
		current_ammo_use_buff 
		
	elif parent_weapon.p.weapons_parent.dodge_buffed:
		# Stats getting improved when dodge buffed
		
		current_shoot_cooldown_buff = 1 + stats.db_shoot_cooldown
		current_bullet_spd_buff 
		current_bullet_amnt_buff 
		current_random_spread_buff 
		current_bullet_lifetime_buff
		current_shoot_delay_buff  
		current_damage_buff 
		#current_max_ammo_buff  
		current_ammo_use_buff 
		
	elif parent_weapon.p.weapons_parent.q_reload_buffed and parent_weapon.p.weapons_parent.dodge_buffed:
		# Stats getting improved when getting both quick reload & dodge buff
		
		current_shoot_cooldown_buff = 1 + stats.qr_shoot_cooldown + stats.db_shoot_cooldown
		current_bullet_spd_buff 
		current_bullet_amnt_buff 
		current_random_spread_buff 
		current_bullet_lifetime_buff
		current_shoot_delay_buff  
		current_damage_buff 
		#current_max_ammo_buff  
		current_ammo_use_buff 
		
	else:
		# Not buffed, no stat improvement
		
		current_shoot_cooldown_buff = 1
		
