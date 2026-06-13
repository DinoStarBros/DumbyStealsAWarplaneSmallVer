extends Node2D
## List of all Components that a projectile has:
## Hitbox component
## Projectile Stats Allocator component
## Projectile Velocity component
## Projectile On Hit FX component
## BTW the default values of the variables are absurdly
## high/low so that I can easily notice errors and stuff
class_name Projectile

var lifetime : float = 0.3
var time_left : float = 0
var dmg : float = 999999

var velocity : Vector2 = Vector2(6, 7)

var weapon_parent_stats : WeaponStats ## The stats of the weapon that shot this projectile out

func move(delta: float) -> void:
	global_position += velocity * delta
