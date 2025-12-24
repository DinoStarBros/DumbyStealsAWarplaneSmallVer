extends Area2D
class_name HitboxComponent

@export var delete_after_hit : bool ## For stuff like projectiles & whatnot that get deleted on hit
@export var projectile_hit_fx_component : ProjectileOnHitFXComponent

var colliders : Array[CollisionShape2D]

var attack : Attack = g.attack
var dmg : float
var rand_sfx_idx : int = 0

signal Hit

func _init() -> void:
	GlobalSignals.Start_Cutscene.connect(_on_start_cutscene)
	GlobalSignals.End_Cutscene.connect(_on_end_cutscene)
	
	area_entered.connect(_on_area_entered)

func _ready() -> void:
	for child in get_children():
		if child is CollisionShape2D:
			colliders.append(child)

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
		
		if delete_after_hit:
			
			projectile_hit_fx_component.hit()
			get_parent().queue_free()
		
		if area.health_component.hp <= 0: # Death of enemy / player
			
			rand_sfx_idx = randi_range(0, 2)
			
			match rand_sfx_idx:
				0: AudioManager.create_2d_audio(global_position, AudioSettings.types.EXPLODE1)
				1: AudioManager.create_2d_audio(global_position, AudioSettings.types.EXPLODE2)
				2: AudioManager.create_2d_audio(global_position, AudioSettings.types.EXPLODE3)
		

func _on_start_cutscene(dur:float) -> void:
	# Disables collision on cutscene so that u can't damage/take damage during cutscene
	for collider in colliders:
		collider.disabled = true

func _on_end_cutscene() -> void:
	# Re enables collisions when cutscene plays
	for collider in colliders:
		collider.disabled = false
