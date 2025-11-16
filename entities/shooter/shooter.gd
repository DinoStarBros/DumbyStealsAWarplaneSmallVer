extends Enemy

var accelerating : = true
var dir_to_targ : Vector2
var target : CharacterBody2D

@onready var velocity_component: VelocityComponent = %VelocityComponent
@onready var rotation_component: RotationComponent = %RotationComponent

func _ready() ->  void:
	_on_target_deviat_timer_timeout()

var target_deviation : Vector2
var direction : Vector2
var dir_to_target_deviate_pos : Vector2
func _physics_process(delta: float) -> void:
	move_and_slide()
	target = g.player
	dir_to_targ = (target.global_position - global_position).normalized()
	
	%flamez.visible = accelerating
	%flameparticles.emitting = accelerating
	%flameparticles.direction = -velocity
	
	dir_to_target_deviate_pos = global_position.direction_to(target.global_position + target_deviation)
	rotation_component.plane_rotation_handling(delta, target.global_position)
	direction = rotation_component.direction
	velocity_component.other_velocity_handle(delta, dir_to_target_deviate_pos, accelerating)

const tdev_range : = 600
func _on_target_deviat_timer_timeout() -> void:
	target_deviation.x = randf_range(-tdev_range,tdev_range)
	target_deviation.y = randf_range(-tdev_range,tdev_range)

func damage(_attack:Attack)->void:
	pass

func Dead(_attack:Attack)->void:
	g.score += 10
	g.killscore += 1
	#g.spawn_txt("10", global_position)
	#g.spawn_xp(global_position, 1)
	set_physics_process(false)

func play_sfx() -> void:
	%shoot.pitch_scale = randf_range(.9,1.1)
	%shoot.play()
	%shoot2.pitch_scale = randf_range(.9,1.1)
	%shoot2.play(.2)
