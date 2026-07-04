extends Button
class_name WeaponSelectButton

var weapon_resource : WeaponStats
var original_position : Vector2
var weapon_select_tab_parent : WeaponSelectTab
var desired_position : Vector2

func _ready() -> void:
	icon = weapon_resource.texture

func _pressed() -> void:
	if SaveLoad.SaveFileData.equipped_weapons.has(weapon_resource):
		# Checks if this weapon was equipped
		
		if SaveLoad.SaveFileData.equipped_weapons.size() <= 1:
			# You HAVE to have equipped atleast one weapon
			g.spawn_txt("Equip atleast 1 weapon", get_global_mouse_position())
		else:
		# This weapon was already equipped, so it removes itself from equipped weapons.
			SaveLoad.SaveFileData.equipped_weapons.remove_at(
				SaveLoad.SaveFileData.equipped_weapons.find(weapon_resource)
			)
	else:
		if SaveLoad.SaveFileData.equipped_weapons.size() >= SaveLoad.SaveFileData.max_weapon_slots:
			# You can't have more than the max amount of weapon slots
			g.spawn_txt("Maximum weapon slots reached", get_global_mouse_position())
		else:
			# This weapon wasn't equipped, so add it to equipped weapons.
			SaveLoad.SaveFileData.equipped_weapons.append(weapon_resource)
	
	weapon_select_tab_parent.refresh_ui()
