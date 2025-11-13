extends Area2D
class_name HitboxComponent

@export var delete_after_hit : bool

var attack : Attack = g.attack
var dmg : float
var rand_sfx_idx : int = 0

signal Hit

func set_attack_properties(damag:float) -> void:
	dmg = damag

func _on_area_entered(area : Area2D) -> void:
	if area is HurtboxComponent:
		Hit.emit()
		if get_parent() is Enemy:
			# An enemy hitbox that damages the player
			
			%player_hit.pitch_scale = 1 + randf_range(-.2,.2)
			%player_hit.play()
		else:
			# A player hitbox that damages enemies
			
			%enemy_hit.pitch_scale = 1 + randf_range(-.1,.1)
			%enemy_hit.play()
			
			%enemy_hit2.pitch_scale = randf_range(0.8,1.3)
			%enemy_hit2.play()
		
		attack.attack_damage = dmg
		area.damage(attack)
		
		if area.health_component.hp <= 0: # Death of enemy / player
			
			rand_sfx_idx = randi_range(0, 2)
			
			match rand_sfx_idx:
				0: AudioManager.create_2d_audio(global_position, AudioSettings.types.EXPLODE1)
				1: AudioManager.create_2d_audio(global_position, AudioSettings.types.EXPLODE2)
				2: AudioManager.create_2d_audio(global_position, AudioSettings.types.EXPLODE3)
