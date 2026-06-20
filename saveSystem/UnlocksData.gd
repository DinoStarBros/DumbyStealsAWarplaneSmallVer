extends RefCounted
## Contains the data of unlocks that are saved & loaded
class_name Unlocks

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
			"unlocked": true,
			"weapon_resource": "res://resources/weapon_stats/Orbiter.tres",
		}
}
