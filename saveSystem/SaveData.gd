extends Resource
class_name SaveDataResource

### SETTINGS DATA ###

@export var master_volume : float = 0.75
@export var music_volume : float = 0.75
@export var sfx_volume : float = 0.75

@export var resolution_index : int = 0

@export var screen_shake_value : bool = true
@export var frame_freeze_value : bool = true

@export var switch_accelerate_roll : bool = false
@export var language_idx : int = 0 ##English=0, Filipino=1

### UNLOCKS AND EQUIPS DATA ###

## Contains the weapons, their unlock status, and other stuff. 
## Key is the weapon resource, value is the unlock status
@export var weapons_unlocked : Dictionary = {
	"res://resources/weapon_stats/Rapid.tres": true,
	"res://resources/weapon_stats/BurstRifle.tres": true,
	"res://resources/weapon_stats/Shotgun.tres": true,
	"res://resources/weapon_stats/Orbiter.tres": false,
	
}
@export var equipped_weapons : Array[WeaponStats] = [
	load("res://resources/weapon_stats/Rapid.tres"),
]
## The amount of weapons that you can select at a time
@export var max_weapon_slots : int = 2

## Contains the plane parts, unlock status, etc. etc.
## Key is the plane part resource, value is the unlock status
@export var plane_parts_unlocked : Dictionary = {
	
}
@export var equipped_plane_parts : Array = []
## Plane parts work like Paper Mario Badge System/Hollow Knight charm system
@export var max_plane_part_slots : int = 3
