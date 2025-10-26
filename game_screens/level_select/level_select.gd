extends Control

func _ready() -> void:
	# Level button signal connections
	%l1.pressed.connect(_l1_pressed)

func _l1_pressed() -> void:
	g.scene_change("res://game_screens/level1/level1.tscn")
