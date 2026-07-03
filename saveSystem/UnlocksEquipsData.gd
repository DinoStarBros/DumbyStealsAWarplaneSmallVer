extends RefCounted
## Contains the data of unlocks that are saved & loaded
## and the equipped weapons & plane parts
class_name UnlocksEquips

## Contains the weapons, their unlock status, and other stuff
var weapons_unlocked : Dictionary = {
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
var equipped_weapons : Array[WeaponStats] = [
	load("res://resources/weapon_stats/Rapid.tres"),
	
]

var max_weapon_slots : int = 2

## Contains the plane parts, unlock status, etc. etc.
var plane_parts_unlocked : Dictionary = {
	
}
var plane_parts_equipped : Array = []
