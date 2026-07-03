extends Node

const save_location : String = "user://SaveFile.tres"

var SaveFileData : SaveDataResource = SaveDataResource.new()

func _ready()->void:
	#_load()
	load_everything()

func _save()->void:
	ResourceSaver.save(SaveFileData, save_location)

func _load()->void:
	if FileAccess.file_exists(save_location):
		SaveFileData = ResourceLoader.load(save_location).duplicate(true)

func _reset_save_file()->void:
	SaveFileData = SaveDataResource.new()
	_save()

var settings : SettingsData = SettingsData.new()
func save_settings_stuff() -> void: ## Saves only the data used in the settings menu
	SaveFileData.master_volume = settings.master_volume
	SaveFileData.music_volume = settings.music_volume
	SaveFileData.sfx_volume = settings.sfx_volume
	
	SaveFileData.frame_freeze = settings.frame_freeze_value
	SaveFileData.screen_shake = settings.screen_shake_value
	SaveFileData.resolutuion_index = settings.resolution_index
	SaveFileData.switch_acc_roll = settings.switch_accelerate_roll
	SaveFileData.language_idx = settings.language_idx
	
	_save()

func load_settings_stuff() -> void: ## Loads settings variables and data
	_load()
	
	settings.master_volume = SaveFileData.master_volume
	settings.music_volume = SaveFileData.music_volume
	settings.sfx_volume = SaveFileData.sfx_volume
	
	settings.frame_freeze_value = SaveFileData.frame_freeze
	settings.screen_shake_value = SaveFileData.screen_shake
	
	settings.resolution_index = SaveFileData.resolutuion_index
	settings.switch_accelerate_roll = SaveFileData.switch_acc_roll
	settings.language_idx = SaveFileData.language_idx

var unlocks_equips : UnlocksEquips = UnlocksEquips.new()
func save_unlocks_equips() -> void:
	SaveFileData.weapons_unlocked = unlocks_equips.weapons_unlocked
	SaveFileData.equipped_weapons = unlocks_equips.equipped_weapons
	SaveFileData.plane_parts_unlocked = unlocks_equips.plane_parts_unlocked
	SaveFileData.plane_parts_equipped = unlocks_equips.plane_parts_equipped
	SaveFileData.max_weapon_slots = unlocks_equips.max_weapon_slots
	
	_save()

func load_unlocks_equips() -> void:
	_load()
	
	unlocks_equips.weapons_unlocked = SaveFileData.weapons_unlocked
	unlocks_equips.equipped_weapons = SaveFileData.equipped_weapons
	unlocks_equips.plane_parts_unlocked = SaveFileData.plane_parts_unlocked
	unlocks_equips.plane_parts_equipped = SaveFileData.plane_parts_equipped

func save_everything() -> void: ## Saves all the SaveFileData according to their current values in the game
	save_settings_stuff()
	save_unlocks_equips()

func load_everything() -> void: ## Loads all the SaveFileData
	load_settings_stuff()
	load_unlocks_equips()

# I will fuck everything up in this branch
# Tryna get rid of intermediate variables & just directly access the SaveFileData variables & stuff

func _physics_process(delta: float) -> void:
	pass
