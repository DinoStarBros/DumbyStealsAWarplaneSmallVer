extends Weapon

func _ready() -> void:
	cooldown = stats.shoot_cooldown
	ammo = stats.max_ammo

func play_sfx() -> void:
	%shootsfx2.pitch_scale = randf_range(0.9, 1.1)
	%shootsfx2.play(0.07)

func play_multi_sfx() -> void:
	%shootsfx.pitch_scale = randf_range(1.2, 1.5)
	%shootsfx.play(0.08)
