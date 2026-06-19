extends VBoxContainer
class_name WeaponSelect

@onready var weapon_parts_select: Control = owner

var weapon_button_scn : PackedScene = preload("res://game_screens/weapon_parts_select/weapon_button/weapon_button.tscn")

var weapons_unlocked : Dictionary = SaveLoad.unlocks.weapons_unlocked
var weapons_items_res : Array[WeaponStats]

func _ready() -> void:
	
	for weapon in weapons_unlocked.values():
		
		if weapon["unlocked"]:
			weapons_items_res.append(
				load(weapon["weapon_resource"])
			
			)
	
	for res in weapons_items_res:
		create_weapon_button(res)

func create_weapon_button(res: WeaponStats) -> void:
	var weapon_button : WeaponButton = weapon_button_scn.instantiate()
	weapon_button.weapon_item_res = res
	add_child(weapon_button)
