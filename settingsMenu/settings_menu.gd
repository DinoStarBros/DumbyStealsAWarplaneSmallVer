extends Control
class_name Settings

func _ready()->void:
	
	%switch_acc_roll.pressed.connect(_on_switch_acc_roll_pressed)
	%translations.item_selected.connect(_on_translations_pressed)
	
	await get_tree().process_frame
	_on_load_pressed()
	
	#_update_res()
	#_update_vol_val()
	
	#for n in %buttons.get_children():
	#	if n is Button:
	#		n.focus_mode = Control.FOCUS_NONE

func _on_save_pressed()->void: ## Saves the settings stuff
	SaveLoad.save_settings_stuff()

func _on_load_pressed()->void: ## Loads the settings stuff
	SaveLoad.load_settings_stuff()
	
	%master_volume.value = Data.settings[Data.MASTER_VOL]
	%music_volume.value = Data.settings[Data.MUSIC_VOL]
	%sfx_vol.value = Data.settings[Data.SFX_VOL]

func old_load() -> void:
	SaveLoad._load()
	g.master_volume = SaveLoad.SaveFileData.master_volume
	g.music_volume = SaveLoad.SaveFileData.music_volume
	g.sfx_volume = SaveLoad.SaveFileData.sfx_volume
	
	%master_volume.value = g.master_volume
	%music_volume.value = g.music_volume
	%sfx_vol.value = g.sfx_volume
	
	g.screen_shake_value = SaveLoad.SaveFileData.screen_shake
	if g.screen_shake_value:
		%screen_shake.text = str("On")
	else:
		%screen_shake.text = str("Off")
	
	g.frame_freeze_value = SaveLoad.SaveFileData.frame_freeze
	if g.frame_freeze_value:
		%frame_freeze.text = str("On")
	else:
		%frame_freeze.text = str("Off")
	
	%resOptions.select(SaveLoad.SaveFileData.resolutuion_index)
	_on_res_options_item_selected(SaveLoad.SaveFileData.resolutuion_index)

func _on_reset_pressed()->void:
	SaveLoad._reset_save_file()
	SaveLoad._load()
	_update_vol_val()
	_update_accessibility_val()
	_update_res()

func _update_vol_val()->void:
	pass

func _update_accessibility_val() -> void:
	pass

func _update_res()->void:
	pass

func _on_master_volume_value_changed(value: float)->void:
	%vol_change_master.pitch_scale = value
	%vol_change_master.play(0.005)
	
	Data.settings[Data.MASTER_VOL] = value

func _on_music_volume_value_changed(value: float)->void:
	%vol_change_music.pitch_scale = value
	%vol_change_music.play(0.005)
	
	Data.settings[Data.MUSIC_VOL] = value

func _on_sfx_vol_value_changed(value: float)->void:
	%vol_change_sfx.pitch_scale = value
	%vol_change_sfx.play(0.005)
	
	Data.settings[Data.SFX_VOL] = value

func _on_res_options_item_selected(index: int) -> void:
	#pass
	g.resolution_index = index
	DisplayServer.window_set_size(resolutions[index])

var resolutions : Array[Vector2i] = [
	Vector2i(1920, 1080),
	Vector2i(1600, 900),
	Vector2i(1280, 720),
]

func _on_back_pressed() -> void:
	_on_save_pressed()
	hide()
	get_tree().paused = false

func _on_frame_freeze_pressed() -> void:
	g.frame_freeze_value = not g.frame_freeze_value
	%button_pressed.pitch_scale = randf_range(1.8,2.2)
	%button_pressed.play()
	
	if g.frame_freeze_value:
		%frame_freeze.text = str("On")
	else:
		%frame_freeze.text = str("Off")

func _on_screen_shake_pressed() -> void:
	g.screen_shake_value = not g.screen_shake_value
	%button_pressed.pitch_scale = randf_range(1.8,2.2)
	%button_pressed.play()
	
	if g.screen_shake_value:
		%screen_shake.text = str("On")
	else:
		%screen_shake.text = str("Off")

func _on_switch_acc_roll_pressed() -> void:
	g.switch_acc_roll = not g.switch_acc_roll
	
	%switch_acc_roll.text = str(
		
		"Switch Accelerate & Roll : \n",
		g.switch_acc_roll
		
		)

enum language_idxs {
	ENGLISH = 0,
	FILIPINO = 1
}

func _on_translations_pressed(index: int) -> void:
	var item_string : String = (
		%translations.get_item_text(index)
	)
	TranslationServer.set_locale(item_string)
