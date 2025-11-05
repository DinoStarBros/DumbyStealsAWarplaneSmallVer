extends Node2D

@export var stats : EnemyStats

@export_category("Components")
@export var hitbox_component : HitboxComponent
@export var health_component : HealthComponent
@export var velocity_component : VelocityComponent
@export var rotation_component : RotationComponent
@export var ene_shoot_component : EnemyShootComponent

func _ready() -> void:
	if hitbox_component:
		hitbox_component.set_attack_properties(stats.damage)
	
	if health_component:
		health_component.max_hp = stats.max_hp
		health_component.hp = health_component.max_hp
	
	if velocity_component:
		velocity_component.max_speed = stats.max_speed
		velocity_component.acceleration = stats.acceleration
	
	if rotation_component:
		rotation_component.turn_speed = stats.turn_speed
	
	if ene_shoot_component:
		ene_shoot_component.projectile_scn = stats.projectile_scn
		ene_shoot_component.projectile_dmg = stats.projectile_dmg
		ene_shoot_component.speed = stats.projectile_speed
		ene_shoot_component.lifetime = stats.projectile_lifetime
		
		ene_shoot_component.rotation_component = rotation_component
		ene_shoot_component.health_component = health_component
		
		ene_shoot_component.min_shoot_cooldown = stats.min_and_max_shoot_cooldown.x
		ene_shoot_component.max_shoot_cooldown = stats.min_and_max_shoot_cooldown.y
