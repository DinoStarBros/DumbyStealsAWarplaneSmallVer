extends Weapon
class_name FlakCannon

func _ready() -> void:
	cooldown = stats.shoot_cooldown
	ammo = stats.max_ammo

func play_sfx() -> void:
	%shoot1.pitch_scale = randf_range(1.3,1.5)
	%shoot2.pitch_scale = randf_range(0.7,0.9)
	%shoot3.pitch_scale = randf_range(0.6,0.8)
	
	%shoot1.play(0.22)
	%shoot2.play()
	%shoot3.play(.08)
