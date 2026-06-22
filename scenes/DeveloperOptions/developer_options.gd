extends CanvasLayer
class_name DeveloperOptions

@onready var add_weapons_parent: GridContainer = %AddWeaponsParent
@onready var spawn_enemies_parent: GridContainer = %SpawnEnemiesParent

func add_weapon(weapon_res: WeaponStats) -> void:
	g.weapons_parent.add_weapon(weapon_res)

func spawn_enemy(enemy_stat_res: EnemyStats) -> void:
	g.sky_enemy_spawner.spawn_enemy(enemy_stat_res)

func _ready() -> void:
	visible = g.enable_developer_options
	
	await get_tree().process_frame
	
	for weapon_resource in weapon_resources:
		make_weapon_button(weapon_resource)
	
	for enemy_resource in enemy_resources:
		make_enemy_button(enemy_resource)

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

func make_weapon_button(weapon_res: WeaponStats) -> void:
	var button : Button = Button.new()
	button.text = weapon_res.key
	button.pressed.connect(func():add_weapon(weapon_res))
	button.focus_mode = Control.FOCUS_NONE
	add_weapons_parent.add_child(button)

func make_enemy_button(enemy_res: EnemyStats) -> void:
	var button : Button = Button.new()
	button.text = enemy_res.key
	button.pressed.connect(func():spawn_enemy(enemy_res))
	button.focus_mode = Control.FOCUS_NONE
	spawn_enemies_parent.add_child(button)
