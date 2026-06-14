extends Node2D
class_name Weapon

@export var weapon_stat_res : WeaponStats
@export var weapon_sfx_handler : WeaponsSFXHandler
@export var weapon_muzzle_flash : WeaponMuzzleFlash

var can_shoot : bool = true
var cooldown : float = 0
var dir_to_mouse : Vector2 ## Normalized direction vector from the player to the mouse
var dist_to_mouse : float ## Distance from the player to the mouse
var rand_spread_vector : Vector2
var plr_rotation_component : RotationComponent

func _ready() -> void:
	cooldown = weapon_stat_res.shoot_cooldown

func play_single_sfx() -> void: ## Plays SFX for when it just shot, once
	weapon_sfx_handler.play_single_sfx()

func play_multi_sfx() -> void: ## For SFX that's supposed to play for each bullet rather than just once on shoot
	weapon_sfx_handler.play_multi_sfx()

func play_muzzle_flash() -> void:
	weapon_muzzle_flash.play_muzzle_flash_anim()

func _physics_process(delta: float) -> void:
	weapon_muzzle_flash.look_at(global_position + plr_rotation_component.direction)
