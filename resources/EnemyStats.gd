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
@export var projectile_speed : float = 500.0
@export var projectile_lifetime : float = 1.0
@export var min_and_max_shoot_cooldown : Vector2 = Vector2(1,2) ## X is the Minimum, Y is the Maximum
@export var projectile_amount : int = 1
@export var shoot_delay : float = 0 ## Delay between each bullet if there's multiple
@export var random_spread : float = 0
@export_category("Shoot SFX")
@export var single_sfx : Array[WeaponsSFXHandler.weapon_sfx]
@export var multi_sfx : Array[WeaponsSFXHandler.weapon_sfx]

@export_category("Extra Stats") ## For enemy specific shite
@export var extra_stats : Dictionary[String, Variant]

@export_category("BEHAVIOR types")
@export var movement_behavior : EnemyMovementBehaviorComponent.BEHAVIOR_TYPE
@export var shoot_behavior : EnemyShootBehaviorComponent.BEHAVIOR_TYPE
