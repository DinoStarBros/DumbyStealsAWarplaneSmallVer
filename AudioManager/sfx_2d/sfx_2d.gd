extends AudioStreamPlayer2D
class_name SFX2D

var audio : AudioSettings
var duration : float

func _ready() -> void:
	%durationTimer.timeout.connect(_on_durationTimer_timeout)
	%durationTimer.start(duration)

func _on_finished() -> void:
	audio.audio_finished()
	AudioManager.general_audio_count -= 1
	queue_free()

func _on_durationTimer_timeout() -> void:
	audio.audio_finished()
	AudioManager.general_audio_count -= 1
	queue_free()
