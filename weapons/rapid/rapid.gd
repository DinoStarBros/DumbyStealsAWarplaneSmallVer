extends Weapon

func _ready() -> void:
	cooldown = stats.shoot_cooldown
	ammo = stats.max_ammo

func play_sfx() -> void:
	%shootsfx.pitch_scale = randf_range(0.5, 0.7)
	%shootsfx2.pitch_scale = randf_range(0.9, 1.3)
	
	%shootsfx.play()
	%shootsfx2.play(0.2)
