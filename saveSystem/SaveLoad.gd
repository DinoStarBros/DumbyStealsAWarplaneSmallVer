extends Node

const save_location : String = "user://SaveFile.tres"

var SaveFileData : SaveDataResource = SaveDataResource.new()

func _ready()->void:
	_load()

func _save()->void:
	ResourceSaver.save(SaveFileData, save_location)

func _load()->void:
	if FileAccess.file_exists(save_location):
		SaveFileData = ResourceLoader.load(save_location).duplicate(true)

func _reset_save_file()->void:
	SaveFileData = SaveDataResource.new()
	_save()


func save_settings_stuff() -> void: ## Saves only the data used in the settings menu
	SaveLoad.SaveFileData.master_volume = Data.settings[Data.MASTER_VOL]
	SaveLoad.SaveFileData.music_volume = Data.settings[Data.MUSIC_VOL]
	SaveLoad.SaveFileData.sfx_volume = Data.settings[Data.SFX_VOL]
	
	SaveLoad.SaveFileData.screen_shake = g.screen_shake_value
	SaveLoad.SaveFileData.frame_freeze = g.frame_freeze_value
	
	SaveLoad.SaveFileData.resolutuion_index = g.resolution_index
	
	SaveLoad._save()

func load_settings_stuff() -> void: ## Loads settings variables and data
	SaveLoad._load()
	
	Data.settings[Data.MASTER_VOL] = SaveLoad.SaveFileData.master_volume
	Data.settings[Data.MUSIC_VOL] = SaveLoad.SaveFileData.music_volume
	Data.settings[Data.SFX_VOL] = SaveLoad.SaveFileData.sfx_volume

func save_everything() -> void: ## Saves all the SaveFileData according to their current values in the game
	pass

func load_everything() -> void: ## Loads all the SaveFileData
	pass
