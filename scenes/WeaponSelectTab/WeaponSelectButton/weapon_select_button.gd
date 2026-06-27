extends Button
class_name WeaponSelectButton

var weapon_resource : WeaponStats
var original_position : Vector2
var weapon_select_tab_parent : WeaponSelectTab
var desired_position : Vector2

func _ready() -> void:
	icon = weapon_resource.texture
