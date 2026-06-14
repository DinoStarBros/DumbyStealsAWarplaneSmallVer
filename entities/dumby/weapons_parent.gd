extends Node2D
class_name WeaponsParent

@export var dumby : Dumby

@onready var rotation_component: RotationComponent = %RotationComponent
@onready var switch_sfx: AudioStreamPlayer = %switch

var current_weapon : Weapon
var current_weapon_idx : int

const weapon_scn : PackedScene = preload("res://scenes/weapon/weapon.tscn")
const weapon_stat_resources : Dictionary = {
	"Rapid": preload("res://resources/weapon_stats/Rapid.tres"),
	"Shotgun": preload("res://resources/weapon_stats/Shotgun.tres"),
	"BurstRifle": preload("res://resources/weapon_stats/BurstRifle.tres"),
	
}

func _ready() -> void:
	#add_weapon(weapon_stat_resources["BurstRifle"])
	for value in weapon_stat_resources.values():
		add_weapon(value)

func add_weapon(weapon_res: WeaponStats) -> void:
	var weapon_node : Weapon = weapon_scn.instantiate()
	weapon_node.weapon_stat_res = weapon_res
	weapon_node.plr_rotation_component = rotation_component
	add_child(weapon_node)
	current_weapon = weapon_node

func _process(delta: float) -> void:
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
