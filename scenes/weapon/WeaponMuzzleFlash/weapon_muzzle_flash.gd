extends Node2D
class_name WeaponMuzzleFlash

@export var weapon_parent : Weapon

@onready var anim: AnimationPlayer = %Anim

enum muzzle_flash_types {
	MF1, 
}

var muzzle_flashes : Array[muzzle_flash_types]

func _ready() -> void:
	muzzle_flashes = weapon_parent.weapon_stat_res.muzzle_flashes

func identify_and_play_muzzle_flash(muzzle_flash: muzzle_flash_types):
	match muzzle_flash:
		muzzle_flash_types.MF1:
			anim.play("mf1")

func play_muzzle_flash_anim():
	for muzzle_flash in muzzle_flashes:
		identify_and_play_muzzle_flash(muzzle_flash)
