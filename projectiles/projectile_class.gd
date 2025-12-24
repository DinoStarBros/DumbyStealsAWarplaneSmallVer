extends Node2D
class_name Projectile

var lifetime : float = 2
var time_left : float = 0
var dmg : float = 5

var velocity : Vector2

var weapon_parent_stats : WeaponStats ## The stats of the weapon that shot this projectile out
