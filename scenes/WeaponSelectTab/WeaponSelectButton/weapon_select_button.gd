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
		
		if SaveLoad.SaveFileData.equipped_weapons.size() <= 1:
			## You HAVE to have equipped atleast one weapon
			pass
		else:
		# This weapon was already equipped, so it removes itself from equipped weapons.
			SaveLoad.SaveFileData.equipped_weapons.remove_at(
				SaveLoad.SaveFileData.equipped_weapons.find(weapon_resource)
			)
	else:
		# This weapon wasn't equipped, so add it to equipped weapons.
		SaveLoad.SaveFileData.equipped_weapons.append(weapon_resource)
	
	weapon_select_tab_parent.refresh_ui()
