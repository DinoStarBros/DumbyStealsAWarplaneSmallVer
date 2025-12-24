extends Node2D
## List of all Components that a projectile has:
## Hitbox component
## Projectile Stats Allocator component
## Projectile Velocity component
## Projectile On Hit FX component
class_name Projectile

var lifetime : float = 2
var time_left : float = 0
var dmg : float = 999999

var velocity : Vector2

var weapon_parent_stats : WeaponStats ## The stats of the weapon that shot this projectile out
