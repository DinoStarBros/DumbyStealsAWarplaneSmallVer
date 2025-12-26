extends RefCounted
## Contains the data of the settings menu that gets saved & loaded
class_name SettingsData

var master_volume : float = 0.0
var music_volume : float = 0.0
var sfx_volume : float = 0.0

var screen_shake_value : bool = true
var frame_freeze_value : bool = true

var resolution_index : int = 0
var switch_accelerate_roll : bool = false

var language_idx : int = 0 ##English=0, Filipino=1
