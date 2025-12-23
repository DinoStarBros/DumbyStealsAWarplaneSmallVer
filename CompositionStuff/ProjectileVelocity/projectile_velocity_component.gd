extends Node2D
## Handles movement and rotations
class_name ProjectileVelocityComponent

@onready var parent_projectile : Projectile = get_parent()

func _ready() -> void:
	if !parent_projectile:
		printerr("This Projectile Velocity Component has to be a direct child of a projectile.")

func _physics_process(delta: float) -> void:
	velocity_handle(delta)

func velocity_handle(delta: float) -> void:
	parent_projectile.global_position += delta * parent_projectile.velocity
