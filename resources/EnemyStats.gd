extends Resource
class_name EnemyStats

@export_category("Hitbox Component") ## Usually Contact damage
@export var damage : float = 1.0

@export_category("Health Component")
@export var max_hp : float = 10.0

@export_category("Velocity Component")
@export var max_speed : float = 900
@export var acceleration : float = 3

@export_category("Rotation Component")
@export var turn_speed : float = 3.0

@export_category("Stats for Ranged Enemies")
@export var projectile_dmg : float = 3.0
@export var projectile_scn : PackedScene = preload("res://projectiles/ene_bullet/ene_bullet.tscn")

@export_category("Extra Stats") ## For enemy specific shite
@export var extra_stats : Dictionary[String, Variant]
