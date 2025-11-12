extends Control

func _ready() -> void:
	%return.grab_focus()
	
	# Level button signal connections
	%l1.pressed.connect(_l1_pressed)
	%return.pressed.connect(_return_pressed)

func _l1_pressed() -> void:
	g.scene_change("res://game_screens/level1/level1.tscn")

func _return_pressed() -> void:
	g.scene_change("res://game_screens/weapon_parts_select/weapon_parts_select.tscn")
