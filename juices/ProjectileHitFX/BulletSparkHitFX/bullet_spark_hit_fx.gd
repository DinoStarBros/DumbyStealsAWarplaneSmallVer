extends ProjectileHitFX

func _ready() -> void:
	%Sparticle.amount = randi_range(20, 30)
	%Sparticle.emitting = true
	%Sparticle.rotation_degrees += 180
	
	AudioManager.create_2d_audio(global_position, AudioSettings.types.ENEMY_HIT1)
	AudioManager.create_2d_audio(global_position, AudioSettings.types.ENEMY_HIT2)
