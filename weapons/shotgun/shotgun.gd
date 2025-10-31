extends Weapon

func _ready() -> void:
	cooldown = stats.shoot_cooldown
	ammo = stats.max_ammo

func play_sfx() -> void:
	%shootsfx.pitch_scale = randf_range(0.8, 1.2)
	%shootsfx2.pitch_scale = randf_range(1.0, 1.2)
	
	%shootsfx.play(0.08)
	%shootsfx2.play(0.2)
