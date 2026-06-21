extends Node2D
class_name WeaponsParent

@export var dumby : Dumby

@onready var rotation_component: RotationComponent = %RotationComponent
@onready var switch_sfx: AudioStreamPlayer = %switch
@onready var evade_box: Evade = %evade_box
@onready var curr_weapon_txt: Label = %curr_weap

var current_weapon : Weapon
var current_weapon_idx : int
var buff_time : float = 0

const WEAPON_SCN : PackedScene = preload("res://scenes/weapon/weapon.tscn")
const WEAPON_STATS_RESOURCES : Dictionary = {
	"Rapid":preload("res://resources/weapon_stats/Rapid.tres"),
	"Shotgun":preload("res://resources/weapon_stats/Shotgun.tres"),
	"BurstRifle":preload("res://resources/weapon_stats/BurstRifle.tres"),
	"Orbiter":preload("res://resources/weapon_stats/Orbiter.tres")
}

func _ready() -> void:
	g.weapons_parent = self
	
	evade_box.Perfect_Roll.connect(
		func():
		buff_time = 5
	)
	if g.current_weapon_button_selected_res:
		add_weapon(g.current_weapon_button_selected_res)
	else:
		#for value in WEAPON_STATS_RESOURCES.values():
		#	add_weapon(value)
		add_weapon(load("res://resources/weapon_stats/Rapid.tres"))
	current_weapon_idx = 0
	switch_weapon(0)

func add_weapon(weapon_res: WeaponStats) -> void:
	var weapon_node : Weapon = WEAPON_SCN.instantiate()
	weapon_node.weapon_stat_res = weapon_res
	weapon_node.plr_rotation_component = rotation_component
	add_child(weapon_node)
	current_weapon = weapon_node
	weapon_visuals()

func _physics_process(delta: float) -> void:
	buff_time = max(0, buff_time - delta)
	
	if Input.is_action_just_pressed("next_weapon"):
		switch_weapon(1)
	elif Input.is_action_just_pressed("prev_weapon"):
		switch_weapon(-1)

func switch_weapon(change: int) -> void:
	switch_sfx.pitch_scale = 1.5 + randf_range(-.2,.2)
	switch_sfx.play(0.17)
	
	current_weapon_idx += change
	current_weapon_idx = wrapi(current_weapon_idx, 0, get_child_count())
	current_weapon = get_child(current_weapon_idx)
	weapon_visuals()

func weapon_visuals() -> void:
	curr_weapon_txt.text = TranslationServer.tr(current_weapon.weapon_stat_res.key + "Name")
