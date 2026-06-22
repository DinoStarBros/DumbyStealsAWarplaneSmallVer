extends CanvasLayer
class_name DeveloperOptions

func add_weapon(weapon_res: WeaponStats) -> void:
	g.weapons_parent.add_weapon(weapon_res)

func spawn_enemy(enemy_stat_res: EnemyStats) -> void:
	g.sky_enemy_spawner.spawn_enemy(enemy_stat_res)

func _ready() -> void:
	visible = g.enable_developer_options
	
	await get_tree().process_frame
	
	#for n in add_weapon_buttons.values(): if n[0] is Button:
		#n[0].pressed.connect(n[1])
	#for n in spawn_enemy_buttons.values(): if n[0] is Button:
		#n[0].pressed.connect(n[1])

const weapon_resources : Array[WeaponStats] = [
	preload("res://resources/weapon_stats/Rapid.tres"),
	preload("res://resources/weapon_stats/BurstRifle.tres"),
	preload("res://resources/weapon_stats/Shotgun.tres"),
	preload("res://resources/weapon_stats/Orbiter.tres"),
	
]
const enemy_resources : Array[EnemyStats] = [
	preload("res://resources/enemy_stats/Chaser.tres"),
	preload("res://resources/enemy_stats/PursuitShooter.tres"),
	preload("res://resources/enemy_stats/DistanceShooter.tres"),
	preload("res://resources/enemy_stats/Shotgunner.tres"),
	preload("res://resources/enemy_stats/SpikeBall.tres"),
	
]

#@onready var add_weapon_buttons : Dictionary = {
	#1:[%Rapid,
		#func(): add_weapon(load("res://resources/weapon_stats/Rapid.tres"))
	#],
	#2:[%Burst,
		#func(): add_weapon(load("res://resources/weapon_stats/BurstRifle.tres"))
	#],
	#3:[%Shotgun,
		#func(): add_weapon(load("res://resources/weapon_stats/Shotgun.tres"))
	#],
	#4:[%Orbit,
		#func(): add_weapon(load("res://resources/weapon_stats/Orbiter.tres"))
	#],
#}
#
#@onready var spawn_enemy_buttons : Dictionary = {
	#1:[%Chaser,
		#func(): spawn_enemy(load("res://resources/enemy_stats/Chaser.tres"))
	#],
	#2:[%PursuitShooter,
		#func(): spawn_enemy(load("res://resources/enemy_stats/PursuitShooter.tres"))
	#],
	#3:[%DistanceShooter,
		#func(): spawn_enemy(load("res://resources/enemy_stats/DistanceShooter.tres"))
	#],
	#4:[%Shotgunner,
		#func(): spawn_enemy(load("res://resources/enemy_stats/Shotgunner.tres"))
	#],
	#5:[%SpikeBall,
		#func(): spawn_enemy(load("res://resources/enemy_stats/SpikeBall.tres"))
	#],
#}
