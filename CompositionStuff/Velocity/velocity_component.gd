extends Node2D
class_name VelocityComponent

@onready var p : CharacterBody2D = get_parent()

@export var max_speed : float = 1000 ## How fast the plane can go
@export var acceleration : float = 4 ## How fast it can go to top speed
@export var trail_particles : CPUParticles2D

var desired_velocity : Vector2
var current_velocity : Vector2
var change_velocity : Vector2

func _ready() -> void:
	pass

func other_velocity_handle(delta: float, direction: Vector2, accelerating: bool) -> void: ## Improved movement for the ship
	## More control, can fly in straight lines 
	desired_velocity = direction * max_speed
	
	change_velocity = (desired_velocity - current_velocity) * acceleration
	
	p.velocity = current_velocity
	
	if accelerating:
		
		current_velocity += change_velocity * delta
	else:
		
		current_velocity.y += (980 * delta) / 4
		p.velocity.y = clamp(p.velocity.y, -max_speed, max_speed)
	
	if trail_particles:
		trail_particles.emitting = accelerating

func _get_velocity_angle_deg() -> float:
	return rad_to_deg(p.velocity.angle())
