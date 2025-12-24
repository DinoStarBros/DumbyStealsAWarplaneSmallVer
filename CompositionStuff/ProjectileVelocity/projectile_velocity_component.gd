extends Node2D
## Handles movement and rotations
## Also handles the lifespan/duration of a bullet lol
class_name ProjectileVelocityComponent

@onready var parent_projectile : Projectile = get_parent()

func _ready() -> void:
	if !parent_projectile:
		printerr("This Projectile Velocity Component has to be the direct child of a projectile!")
	
	parent_projectile.time_left = parent_projectile.lifetime

func _physics_process(delta: float) -> void:
	velocity_handle(delta)
	
	parent_projectile.time_left -= delta
	if parent_projectile.time_left <= 0:
		parent_projectile.queue_free()

func velocity_handle(delta: float) -> void:
	parent_projectile.global_position += delta * parent_projectile.velocity
