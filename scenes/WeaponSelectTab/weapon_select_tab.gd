extends Control
class_name WeaponSelectTab

@onready var unlocked_unequipped_weapons_grid: GridContainer = %UnlockedUnequippedWeaponsGrid
@onready var equipped_weapons_grid: GridContainer = %EquippedWeaponsGrid

var weapon_resources : Array[WeaponStats]

const weapon_select_button_scn : PackedScene = preload("res://scenes/WeaponSelectTab/WeaponSelectButton/weapon_select_button.tscn")

func _ready() -> void:
	
	for weapon in SaveLoad.unlocks_equips.weapons_unlocked.values():
		if weapon["unlocked"]:
			spawn_weapon_select_button(
				load(weapon["weapon_resource"]),
				unlocked_unequipped_weapons_grid
			)

func spawn_weapon_select_button(weapon_resource: WeaponStats, parent_grid: GridContainer) -> void:
	var weapon_select_button : WeaponSelectButton = weapon_select_button_scn.instantiate()
	weapon_select_button.weapon_resource = weapon_resource
	weapon_select_button.weapon_select_tab_parent = self
	parent_grid.add_child(weapon_select_button)
