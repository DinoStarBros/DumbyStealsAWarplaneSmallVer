extends Node

var upgrades_res : Array[Resource] = [
	load("res://shop/upgradesResource/damage_upgrade.tres"),
	load("res://shop/upgradesResource/hp_upgrade.tres"),
	#load("res://shop/upgradesResource/lightningc_upgrade.tres"),
	load("res://shop/upgradesResource/rotation_upgrade.tres"),
	load("res://shop/upgradesResource/speed_upgrade.tres"),
	load("res://shop/upgradesResource/missile_upgrade.tres"),
	
]

const projectile_scns : Dictionary = {
	"bullet": "res://projectiles/plr_bullet/bullet.tscn",
	"homing_rocket": "res://projectiles/homing_rocket/homing_rocket.tscn",
}

const summon_scns : Dictionary = {
	"shooter_summon": "res://projectiles/shooter_summons/shooter_summon.tscn",
}

var enemy_projectile_scns : Dictionary = {
	
}
