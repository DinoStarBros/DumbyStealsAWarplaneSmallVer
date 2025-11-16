extends Node

signal Wave_End
signal Upgrade_End

signal Boss_Spawned(
	boss_position: Vector2,
	cutscene_duration : float
	)
signal Boss_Defeated(
	boss_position: Vector2,
	cutscene_duration : float
	)

signal Start_Cutscene(
	cutscene_duration : float
	)
signal End_Cutscene

func _init() -> void:
	Wave_End.connect(_on_wave_end)
	Upgrade_End.connect(_on_upgrade_end)
	
	Boss_Spawned.connect(_on_boss_spawned)
	Boss_Defeated.connect(_on_boss_defeated)
	
	Start_Cutscene.connect(_on_start_cutscene)
	End_Cutscene.connect(_on_end_cutscene)

func _on_wave_end() -> void:
	pass

func _on_upgrade_end() -> void:
	pass

func _on_boss_spawned(boss_pos: Vector2, cutscene_duration: float) -> void:
	Start_Cutscene.emit(cutscene_duration)

func _on_boss_defeated(boss_pos: Vector2, cutscene_duration: float) -> void:
	Start_Cutscene.emit(cutscene_duration)

func _on_start_cutscene(cutscene_duration: float) -> void:
	g.game_state = g.game_states.Cutscene
	await get_tree().create_timer(cutscene_duration).timeout
	
	End_Cutscene.emit()

func _on_end_cutscene() -> void:
	g.game_state = g.game_states.Combat
