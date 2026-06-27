extends Control
class_name WeaponPartSelectScreen

@onready var return_button: Button = %return_button
@onready var weapon_select_tab: WeaponSelectTab = %WeaponSelectTab
@onready var plane_parts_select_tab: PlanePartsSelectTab = %PlanePartsSelectTab

func _return_pressed() -> void:
	SaveLoad.save_everything()
	g.scene_change("res://game_screens/level_and_weapon_select/level_and_weapon_select.tscn")

func _ready() -> void:
	SaveLoad.load_everything()
	
	return_button.pressed.connect(_return_pressed)
	return_button.grab_focus()
