extends Enemy
class_name GenericEnemy

func _physics_process(delta : float) -> void:
	move_and_slide()
	
	%flamez.visible = true
	%flameparticles.emitting = true
	%flameparticles.direction = -velocity

#func Dead(_attack:Attack)->void:
	#g.score += 10
	#g.killscore += 1
	#set_physics_process(false)
