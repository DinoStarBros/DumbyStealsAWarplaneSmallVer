extends Control
class_name Settings

func _ready()->void:
	
	%switch_acc_roll.pressed.connect(_on_switch_acc_roll_pressed)
	%translations.item_selected.connect(_on_translations_pressed)
	
	await get_tree().process_frame
	_on_load_pressed()
	
	%translations.select(SaveLoad.settings.language_idx)
	_on_translations_pressed(SaveLoad.settings.language_idx)
	
	#_update_res()
	#_update_vol_val()
	
	#for n in %buttons.get_children():
	#	if n is Button:
	#		n.focus_mode = Control.FOCUS_NONE

func _on_save_pressed()->void: ## Saves the settings stuff
	SaveLoad.save_settings_stuff()

func _on_load_pressed()->void: ## Loads the settings stuff
	SaveLoad.load_settings_stuff()
	
	# Updates the visuals and sliders in the settings menu
	%master_volume.value = SaveLoad.settings.master_volume
	%music_volume.value = SaveLoad.settings.music_volume
	%sfx_vol.value = SaveLoad.settings.sfx_volume
	
	if SaveLoad.settings.screen_shake_value:
		%screen_shake.text = str("On")
	else:
		%screen_shake.text = str("Off")
	
	if SaveLoad.settings.frame_freeze_value:
		%frame_freeze.text = str("On")
	else:
		%frame_freeze.text = str("Off")
		
	%resOptions.select(SaveLoad.settings.resolution_index)
	_on_res_options_item_selected(SaveLoad.settings.resolution_index)

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
	
	SaveLoad.settings.master_volume = value

func _on_music_volume_value_changed(value: float)->void:
	%vol_change_music.pitch_scale = clamp(value, 0.1, 10)
	%vol_change_music.play(0.005)
	
	SaveLoad.settings.music_volume = value

func _on_sfx_vol_value_changed(value: float)->void:
	%vol_change_sfx.pitch_scale = clamp(value, 0.1, 10)
	%vol_change_sfx.play(0.005)
	
	SaveLoad.settings.sfx_volume = value

func _on_res_options_item_selected(index: int) -> void:
	#pass
	SaveLoad.settings.resolution_index = index
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
	SaveLoad.settings.frame_freeze_value = not SaveLoad.settings.frame_freeze_value
	%button_pressed.pitch_scale = randf_range(1.8,2.2)
	%button_pressed.play()
	
	if SaveLoad.settings.frame_freeze_value:
		%frame_freeze.text = str("On")
	else:
		%frame_freeze.text = str("Off")

func _on_screen_shake_pressed() -> void:
	SaveLoad.settings.screen_shake_value = not SaveLoad.settings.screen_shake_value
	%button_pressed.pitch_scale = randf_range(1.8,2.2)
	%button_pressed.play()
	
	if SaveLoad.settings.screen_shake_value:
		%screen_shake.text = str("On")
	else:
		%screen_shake.text = str("Off")

func _on_switch_acc_roll_pressed() -> void:
	SaveLoad.settings.switch_accelerate_roll = not SaveLoad.settings.switch_accelerate_roll
	
	%switch_acc_roll.text = str(
		
		"Switch Accelerate & Roll : \n",
		SaveLoad.settings.switch_accelerate_roll
		
		)

enum language_idxs {
	ENGLISH = 0,
	FILIPINO = 1
}

func _on_translations_pressed(index: int) -> void:
	SaveLoad.settings.language_idx = index
	
	var item_string : String = (
		%translations.get_item_text(index)
	)
	TranslationServer.set_locale(item_string)
