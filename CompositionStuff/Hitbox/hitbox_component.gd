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
		if get_parent().is_in_group("Enemy"):
			# An enemy hitbox that damages the player
			
			attack.ene_attack_damage = dmg
			%player_hit.pitch_scale = 1 + randf_range(-.2,.2)
			%player_hit.play()
		else:
			# A player hitbox that damages enemies
			
			attack.attack_damage = dmg
			
			%enemy_hit.pitch_scale = 1 + randf_range(-.1,.1)
			%enemy_hit.play()
			
			%enemy_hit2.pitch_scale = randf_range(0.8,1.3)
			%enemy_hit2.play()
		area.damage(attack)
		
		if delete_after_hit:
			if get_parent().is_in_group("Enemy"):
				var plr_hit_sfx : Node2D = plr_hit_sfx_scn.instantiate()
				g.game.add_child(plr_hit_sfx)
				get_parent().queue_free()
			else:
				var enemy_hit_sfx : Node2D = enemy_hit_sfx_scn.instantiate()
				g.game.add_child(enemy_hit_sfx)
				get_parent().queue_free()
		
		if area.health_component.hp <= 0: # Death of enemy / player
			
			rand_sfx_idx = randi_range(0, 2)
			
			if rand_sfx_idx == 0:
				AudioManager.create_2d_audio(global_position, AudioSettings.types.EXPLODE1)
			if rand_sfx_idx == 1:
				AudioManager.create_2d_audio(global_position, AudioSettings.types.EXPLODE2)
			else:
				AudioManager.create_2d_audio(global_position, AudioSettings.types.EXPLODE3)

const enemy_hit_sfx_scn : PackedScene = preload("res://spawned_sounds/enemy_hit_sfx.tscn")
const plr_hit_sfx_scn : PackedScene = preload("res://spawned_sounds/plr_hit_sfx.tscn")
