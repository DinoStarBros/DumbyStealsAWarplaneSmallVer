extends Node2D

var general_audio_count : int = 0

const general_limit : int = 50

@export var audios : Array[AudioSettings]

var sfx_2d_scn : PackedScene = preload("res://AudioManager/sfx_2d/sfx_2d.tscn")
var audio : AudioSettings
func create_2d_audio(location: Vector2, type: AudioSettings.types) -> void:
	for n in audios:
		if n.type == type:
			audio = n
	
	if not audio.reached_limit() and not general_limit_reached():
		var sfx_2d : SFX2D = sfx_2d_scn.instantiate()
		add_child(sfx_2d)
		sfx_2d.global_position = location
		
		sfx_2d.stream = audio.audio_stream
		sfx_2d.pitch_scale = randf_range(audio.min_pitch, audio.max_pitch)
		sfx_2d.volume_db = audio.volume_db
		sfx_2d.audio = audio
		sfx_2d.duration = audio.duration
		audio.change_audio_count(1)
		general_audio_count += 1
		
		sfx_2d.play(audio.starting_point)

func general_limit_reached() -> bool:
	return general_audio_count > general_limit
