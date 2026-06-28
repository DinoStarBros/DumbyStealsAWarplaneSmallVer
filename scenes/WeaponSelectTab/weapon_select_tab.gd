extends Control
class_name WeaponSelectTab

@onready var unlocked_unequipped_weapons_grid: GridContainer = %UnlockedUnequippedWeaponsGrid
@onready var equipped_weapons_grid: GridContainer = %EquippedWeaponsGrid
@onready var equipped_weapons_text: Label = %equipped_weapons

var weapon_resources : Array[WeaponStats]

const weapon_select_button_scn : PackedScene = preload("res://scenes/WeaponSelectTab/WeaponSelectButton/weapon_select_button.tscn")

func _ready() -> void:
	await get_tree().process_frame
	refresh_ui()

func refresh_ui() -> void:
	## Delete all the weapon buttons first
	for child in equipped_weapons_grid.get_children():
		child.queue_free()
	for child in unlocked_unequipped_weapons_grid.get_children():
		child.queue_free()
	
	for weapon in SaveLoad.unlocks_equips.weapons_unlocked.values(): if weapon["unlocked"]:
		# Looks through all the weapons that are unlocked
		
		if SaveLoad.unlocks_equips.equipped_weapons.has(load(weapon["weapon_resource"])):
			# If a weapon's been equipped, add it to the equipped weapons grid
			spawn_weapon_select_button(
				load(weapon["weapon_resource"]),
				equipped_weapons_grid
			)
		
		else:
			# If a weapon's only unlocked and not equipped, add it here
			spawn_weapon_select_button(
				load(weapon["weapon_resource"]),
				unlocked_unequipped_weapons_grid
			)

func spawn_weapon_select_button(weapon_resource: WeaponStats, parent_grid: GridContainer) -> void:
	var weapon_select_button : WeaponSelectButton = weapon_select_button_scn.instantiate()
	weapon_select_button.weapon_resource = weapon_resource
	weapon_select_button.weapon_select_tab_parent = self
	parent_grid.add_child(weapon_select_button)

func _physics_process(delta: float) -> void:
	equipped_weapons_text.text = str(SaveLoad.unlocks_equips.equipped_weapons)
