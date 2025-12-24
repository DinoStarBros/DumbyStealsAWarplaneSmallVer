extends Node2D
## The component that handles component connections w/ each other & shii
class_name ProjectileStatsAllocator

@onready var parent_projectile : Projectile = get_parent()

@export var hitbox_component : HitboxComponent

func _ready() -> void:
	if !parent_projectile:
		printerr("This Projectile Stats Allocator Component has to be the direct child of a projectile!")
	
	hitbox_component.set_attack_properties(parent_projectile.dmg)
