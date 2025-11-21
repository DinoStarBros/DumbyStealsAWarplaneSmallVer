extends Resource
class_name AudioSettings

enum types {
	EXPLODE1,
	EXPLODE2,
	EXPLODE3,
	ENEMY_HIT,
	
	FLAK_BALL_BLOW1,
}

@export var audio_stream : AudioStream
@export var limit : int = 10
@export var type : types
@export var volume_db : float = 0.0
@export var min_pitch : float = 1.0
@export var max_pitch : float = 1.0
@export var starting_point : float
@export var duration : float = 1.5

var audio_count : int

func change_audio_count(increment : int) -> void:
	audio_count += increment

func reached_limit() -> bool:
	return audio_count > limit

func audio_finished() -> void:
	change_audio_count(-1)
