extends AudioStreamPlayer2D
class_name SFX2D

var audio : AudioSettings

func _on_finished() -> void:
	audio.audio_finished()
	AudioManager.general_audio_count -= 1
	queue_free()
