extends CanvasLayer

# The script for handling shop upgrades in between waves

func _ready() -> void:
	GlobalSignals.Wave_End.connect(_on_wave_end)
	GlobalSignals.Upgrade_End.connect(_on_upgrade_end)

func _on_wave_end() -> void:
	get_tree().paused = true

func _on_upgrade_end() -> void: # After selecting / skipping upgrade
	g.game_state = g.game_states.Combat
	get_tree().paused = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("accelerate"):
		if g.game_state == g.game_states.LevelUp:
			GlobalSignals.Upgrade_End.emit()

func _process(_delta: float) -> void:
	#print(g.gs_strings[g.game_state])
	pass
