extends Node
class_name JetLoopSfxHandler

@onready var jetstart: AudioStreamPlayer = %jetstart
@onready var jetloop: AudioStreamPlayer = %jetloop

@export var dumby : Dumby

var jetstarts_played : int = 0

func _physics_process(delta: float) -> void:
	if dumby.accelerating:
		if jetstarts_played >= 2:
			jetloop_play()
		else:
			jetstart_play()
	else:
		jetstarts_played = 0
		jetstart.stop()
		jetloop.stop()

func jetstart_play() -> void:
	jetloop.stop()
	if not jetstart.playing:
		jetstarts_played += 1
		jetstart.play()

func jetloop_play() -> void:
	jetstart.stop()
	if not jetloop.playing:
		jetloop.play()
