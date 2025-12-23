extends Node

var items_res : Array[UpgradeItem] = [
	load("res://inventoryStuff/upgrade_item_res/Damage1.tres"),
	load("res://inventoryStuff/upgrade_item_res/SpeedUp1.tres"),
	load("res://inventoryStuff/upgrade_item_res/Rot1.tres"),
	load("res://inventoryStuff/upgrade_item_res/Hp1.tres"),
	load("res://inventoryStuff/upgrade_item_res/HmShooter1.tres"),
	load("res://inventoryStuff/upgrade_item_res/hmRetal1.tres")
	
]

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
