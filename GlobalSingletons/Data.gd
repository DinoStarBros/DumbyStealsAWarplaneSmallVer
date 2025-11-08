extends Node
class_name SLData ## Stuff that holds the variables in SaveLoad data to separate it from the g (Global) autoload

const MASTER_VOL : String = "master_volume"
const MUSIC_VOL : String = "music_volume"
const SFX_VOL : String = "sfx_volume"
const SS_VAL : String = "screen_shake_value"
const FF_VAL : String = "frame_freeze_value"
const RES_IDX : String = "resolution_index"

var settings : Dictionary = {
	"master_volume": 0.75,
	"music_volume": 0.75,
	"sfx_volume": 0.75,
	
	"screen_shake_value": true,
	"frame_freeze_value": true,
	
	"resolution_index": 0,
}

func _process(delta: float) -> void:
	print(settings[RES_IDX])
