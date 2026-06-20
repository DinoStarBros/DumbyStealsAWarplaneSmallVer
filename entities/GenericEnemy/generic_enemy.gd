extends Enemy
class_name GenericEnemy

func _physics_process(delta : float) -> void:
	move_and_slide()
	
	%flamez.visible = true
	%flameparticles.emitting = true
	%flameparticles.direction = -velocity
