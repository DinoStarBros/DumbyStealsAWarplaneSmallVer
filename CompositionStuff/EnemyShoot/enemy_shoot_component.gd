extends Node2D
class_name EnemyShootComponent

@export var has_animation : bool ## For enemies that have an animation / telegraph before shooting
var rotation_component : RotationComponent
var health_component : HealthComponent

var shooting : bool = true ## If there needs to be conditions for the enemy to start shooting

var projectile_scn : PackedScene
var projectile_dmg : float = 5.0
var speed : float = 500.0
var lifetime : float = 1.0
var min_shoot_cooldown : float = 5.0
var max_shoot_cooldown : float = 5.0

var shoot_cd : float = 0
var scdt : float

func _ready() -> void:
	%ShootTimer.timeout.connect(_shoot_timeout)
	
	await get_tree().process_frame
	scdt = randf_range(min_shoot_cooldown, max_shoot_cooldown)
	%ShootTimer.start(scdt)

func shoot() -> void:
	if get_parent().has_method("play_sfx"):
		get_parent().play_sfx()
	
	var projectile : Projectile = projectile_scn.instantiate()
	projectile.lifetime = lifetime
	projectile.dmg = projectile_dmg
	projectile.global_position = global_position
	
	projectile.velocity = rotation_component.direction * speed
	projectile.pos_to_look = global_position + rotation_component.direction
	
	g.game.add_child(projectile)

func _shoot_timeout() -> void:
	if health_component.hp > 0:
		if shooting:
			shoot()
		scdt = randf_range(min_shoot_cooldown, max_shoot_cooldown)
		%ShootTimer.start(scdt)
