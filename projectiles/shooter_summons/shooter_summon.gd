extends CharacterBody2D
class_name ShooterSummon

const bullet_spd : float = 2000
const dist_from_plr : float = 250
const starting_speed : float = 1000

var rand_dir : Vector2
var dir_to_targ : Vector2
var newly_summoned : bool = true
var desired_position : Vector2
var dir_to_desire_pos : Vector2
var rand_desire_pos : Vector2
var summon_index : int 
var rand_deg_dir : float
var max_summon_amount : int
var speed_mult : float

func _ready() -> void:
	speed_mult = randf_range(0.8, 1.2)
	
	%shooTimer.timeout.connect(_on_shoo_timer_timeout)
	%lifeTimer.timeout.connect(_on_lifetimer_timeout)
	
	#rand_deg_dir = deg_to_rad(randf_range(-180, 180))
	rand_deg_dir = deg_to_rad((360 / max_summon_amount) * summon_index)
	
	rand_dir.x = cos(rand_deg_dir)
	rand_dir.y = sin(rand_deg_dir)
	
	velocity = rand_dir * starting_speed
	
	rand_desire_pos = rand_dir * dist_from_plr
	
	%shooTimer.start(randf_range(0.3, 0.4))

func _physics_process(delta: float) -> void:
	
	if newly_summoned:
		velocity *= 0.9
		if velocity.length() <= 40:
			newly_summoned = false
	else:
		desired_position = g.player.global_position + rand_desire_pos
		dir_to_desire_pos = global_position.direction_to(desired_position)
		
		velocity = (desired_position - global_position) * 2 * speed_mult
	
	if velocity.x > 0:
		%sprite.rotation_degrees = lerp(rotation_degrees, 100.0, 12.0 * delta)
	else:
		%sprite.rotation_degrees = lerp(rotation_degrees, -100.0, 12.0 * delta)
	
	if target:
		dir_to_targ = global_position.direction_to(target.global_position)
	
	move_and_slide()
	
	if %detect_area.get_overlapping_areas().size() != 0:
		for n : Area2D in %detect_area.get_overlapping_areas():
			if n.get_parent().is_in_group("Enemy"):
				target = n.get_parent()


var target : CharacterBody2D

var bullet_scn : PackedScene = preload("res://projectiles/plr_bullet/bullet.tscn")
func spawn_bullet() -> void:
	%shoot1.pitch_scale = randf_range(1.2, 1.4)
	%shoot1.play()
	
	%shoot2.pitch_scale = randf_range(1.2, 1.4)
	%shoot2.play(0.18)
	
	var bullet : Projectile = bullet_scn.instantiate()
	g.game.add_child(bullet)
	
	bullet.global_position = global_position
	bullet.velocity = dir_to_targ * bullet_spd
	bullet.look_at(global_position + bullet.velocity)
	bullet.dmg = 4

func _on_shoo_timer_timeout() -> void:
	if target:
		spawn_bullet()

func _on_lifetimer_timeout() -> void:
	queue_free()
