extends Control
class_name WeaponPartSelectScreen

@onready var return_button: Button = %return_button

func _return_pressed() -> void:
	g.scene_change("res://game_screens/level_and_weapon_select/level_and_weapon_select.tscn")

func _ready() -> void:
	return_button.grab_focus()
	
	return_button.pressed.connect(_return_pressed)
