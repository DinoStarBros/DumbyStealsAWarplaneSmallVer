extends Node

var items_res : Array[ItemData] = [
	load("res://inventoryStuff/item_resources/Damage1.tres"),
	load("res://inventoryStuff/item_resources/SpeedUp1.tres"),
	load("res://inventoryStuff/item_resources/Rot1.tres"),
	load("res://inventoryStuff/item_resources/Hp1.tres"),
	load("res://inventoryStuff/item_resources/HmShooter1.tres"),
	load("res://inventoryStuff/item_resources/hmRetal1.tres")
	
]

const projectile_scns : Dictionary = {
	"bullet": "res://projectiles/plr_bullet/bullet.tscn",
	"homing_rocket": "res://projectiles/homing_rocket/homing_rocket.tscn",
	"explosion": "res://projectiles/explosion/explosion.tscn",
	
	
}

const summon_scns : Dictionary = {
	"shooter_summon": "res://projectiles/shooter_summons/shooter_summon.tscn",
}

var enemy_projectile_scns : Dictionary = {
	
}
