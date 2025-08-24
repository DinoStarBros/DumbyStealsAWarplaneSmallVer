extends Control
class_name Shop

@onready var p : WaveUpgrade = get_parent()

func _ready() -> void:
	# Signal connections
	GlobalSignals.Wave_End.connect(_on_wave_end)
	
	%skip.pressed.connect(_on_skip_pressed)
	%reroll.pressed.connect(_on_reroll_pressed)
	%select.pressed.connect(_on_select_pressed)

func _on_skip_pressed() -> void:
	if p.allow_upgrade_end:
		GlobalSignals.Upgrade_End.emit()

func _on_reroll_pressed() -> void:
	if p.allow_upgrade_end:
		pass

func _on_select_pressed() -> void:
	if p.allow_upgrade_end:
		pass

func _on_wave_end() -> void:
	%select.grab_focus()
