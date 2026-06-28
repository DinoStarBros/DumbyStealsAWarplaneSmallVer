extends Resource
class_name SaveDataResource

### SETTINGS DATA ###

@export var master_volume : float = 0.75
@export var music_volume : float = 0.75
@export var sfx_volume : float = 0.75

@export var resolutuion_index : int = 0

@export var screen_shake : bool = true
@export var frame_freeze : bool = true

@export var switch_acc_roll : bool = false
@export var language_idx : int = 0 ##English=0, Filipino=1

### UNLOCKS AND EQUIPS DATA ###

## Contains the weapons, their unlock status, and other stuff
@export var weapons_unlocked : Dictionary = {
	"rapid":
		{
			"unlocked": true,
			"weapon_resource": "res://resources/weapon_stats/Rapid.tres",
		},
	
	"burstRifle":
		{
			"unlocked": true,
			"weapon_resource": "res://resources/weapon_stats/BurstRifle.tres",
		},
	
	"shotgun":
		{
			"unlocked": true,
			"weapon_resource": "res://resources/weapon_stats/Shotgun.tres",
		},
	
	"orbiter":
		{
			"unlocked": false,
			"weapon_resource": "res://resources/weapon_stats/Orbiter.tres",
		}
}
@export var equipped_weapons : Array[WeaponStats] = [
	load("res://resources/weapon_stats/Rapid.tres"),
]

## Contains the plane parts, unlock status, etc. etc.
@export var plane_parts_unlocked : Dictionary = {
	
}
@export var plane_parts_equipped : Array = []
