extends Node
class_name AudioStreamPlayerNodePlayer

# PLays AudioStreamPlayer with customizations in just one line.
# This may be very stupid who knows.
func play_AudioStreamPlayer(
	node: AudioStreamPlayer,
	start_point: float = 0.0,
	base_pitch: float = 1.0,
	pitch_rand: float = 0.1,
	delay: float = 0.0
	
) -> void:
	await get_tree().create_timer(delay).timeout
	
	node.pitch_scale = base_pitch + randf_range(-pitch_rand,pitch_rand)
	node.play(start_point)
