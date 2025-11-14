extends Node

signal Wave_End
signal Upgrade_End

signal Boss_Spawned
signal Boss_Defeated

signal Start_Cutscene(cutscene_duration : float)
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

func _on_boss_spawned() -> void:
	Start_Cutscene.emit(3)

func _on_boss_defeated() -> void:
	pass

func _on_start_cutscene(cutscene_duration) -> void:
	g.game_state = g.game_states.Cutscene
	await get_tree().create_timer(cutscene_duration).timeout
	
	End_Cutscene.emit()

func _on_end_cutscene() -> void:
	g.game_state = g.game_states.Combat
