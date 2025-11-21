extends Node2D

var bullet_scn : PackedScene = load(References.projectile_scns["bullet"])

func _ready() -> void:
	%Timer.timeout.connect(_timeout)
	buss()

func _timeout() -> void:
	queue_free()

func buss() -> void:
	AudioManager.create_2d_audio(global_position, AudioSettings.types.FLAK_BALL_BLOW1)
	for n in 30:
		call_deferred("spawn_bullet")
		#spawn_bullet()

func spawn_bullet() -> void:
	var projectile : Projectile = bullet_scn.instantiate()
	projectile.lifetime = .5
	projectile.dmg = 3 * (1.0 + PlayerStats.percent_damage)
	g.game.add_child(projectile)
	
	var trig_val : float = randf_range(-6.28, 6.28)
	
	projectile.global_position = global_position
	projectile.velocity.x = cos(trig_val) * 1000
	projectile.velocity.y = sin(trig_val) * 1000
	#projectile.global_position += projectile.velocity.normalized() * 50
	projectile.look_at(projectile.global_position + projectile.velocity)
	
	projectile.dmg = 3 * (1.0 + PlayerStats.percent_damage)
