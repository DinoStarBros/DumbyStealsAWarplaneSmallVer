extends Node2D
class_name WeaponsParent

@export var dumby : Dumby

var current_weapon : Weapon

const weapon_scn : PackedScene = preload("res://scenes/weapon/weapon.tscn")
const weapon_stat_resources : Dictionary = {
	"Rapid": "res://resources/weapon_stats/Rapid.tres",
	
}

func _ready() -> void:
	add_weapon(preload(weapon_stat_resources["Rapid"]))

func add_weapon(weapon_res: WeaponStats) -> void:
	var weapon_node : Weapon = weapon_scn.instantiate()
	weapon_node.weapon_stat_res = weapon_res
	add_child(weapon_node)
	current_weapon = weapon_node
