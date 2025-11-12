extends Button
class_name WeaponButton

var weapon_parts_select : WeaponPartsSelect
var weapons_select : WeaponSelect
var weapon_item_res : WeaponItem

func _ready() -> void:
	# Da visuals
	icon = weapon_item_res.texture
	text = TranslationServer.tr(weapon_item_res.name_key_start + "Name")
	
	# Da referemces
	await get_tree().process_frame
	weapons_select = get_parent()
	weapon_parts_select = weapons_select.weapon_parts_select

func _pressed() -> void:
	weapon_parts_select.current_weapon_button_selected_res = self
