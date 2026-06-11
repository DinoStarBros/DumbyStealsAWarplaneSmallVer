extends Node

var weapon_items_res : Array[WeaponItem] = [
	load("res://resources/weapon_items_res/rapidItem.tres"),
	load("res://resources/weapon_items_res/burstRifleItem.tres"),
	load("res://resources/weapon_items_res/shotgunItem.tres"),
	
]

const projectile_scns : Dictionary = {
	"bullet": "res://projectiles/plr_bullet/bullet.tscn",
	"homing_rocket": "res://projectiles/homing_rocket/homing_rocket.tscn",
	"explosion": "res://projectiles/explosion/explosion.tscn",
	"flak_ball": "res://projectiles/plr_flak_ball/flak_ball.tscn",
	
}

const summon_scns : Dictionary = {
	"shooter_summon": "res://projectiles/shooter_summons/shooter_summon.tscn",
}

var enemy_projectile_scns : Dictionary = {
	
}
