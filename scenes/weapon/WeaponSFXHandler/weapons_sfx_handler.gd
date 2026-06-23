extends Node2D
## For weapons, but could also be for EnemyShootComponent
class_name WeaponsSFXHandler

@export var weapon_parent : Weapon
@export var enemy_shoot_component : EnemyShootComponent

@onready var aspnp: AudioStreamPlayerNodePlayer = %ASPNodePlayer

var single_sfxs : Array
var multi_sfxs : Array

enum weapon_sfx {
	Gun1, Gun2, Gun3,
	Gun4, Gun5, Gun6,
	Gun7, 
	
}

func identify_and_play_sfx_type(sfx: weapon_sfx) -> void:
	match sfx:
		weapon_sfx.Gun1:
			aspnp.play_AudioStreamPlayer(%gun1)
		weapon_sfx.Gun2:
			aspnp.play_AudioStreamPlayer(%gun2, 0.16, 1.2)
		weapon_sfx.Gun3:
			aspnp.play_AudioStreamPlayer(%gun3, 0.08, 0.8)
		weapon_sfx.Gun4:
			aspnp.play_AudioStreamPlayer(%gun4, 0.16, 1.2)
		weapon_sfx.Gun5:
			aspnp.play_AudioStreamPlayer(%gun5, 0.08, 0.8)
		weapon_sfx.Gun6:
			aspnp.play_AudioStreamPlayer(%gun6, 0.05)
		weapon_sfx.Gun7:
			aspnp.play_AudioStreamPlayer(%gun7, 0, 1, 0.2)

func _ready() -> void:
	if weapon_parent:
		single_sfxs = weapon_parent.weapon_stat_res.single_sfx
		multi_sfxs = weapon_parent.weapon_stat_res.multi_sfx
	
		for child in get_children():
			if child is AudioStreamPlayer2D:
				child.volume_db += 5
		
		
	if enemy_shoot_component:
		single_sfxs = enemy_shoot_component.single_sfx
		multi_sfxs = enemy_shoot_component.multi_sfx

func play_single_sfx() -> void:
	for sfx in single_sfxs:
		identify_and_play_sfx_type(sfx)

func play_multi_sfx() -> void:
	for sfx in multi_sfxs:
		identify_and_play_sfx_type(sfx)
