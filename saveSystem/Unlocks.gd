extends RefCounted
## Contains the data of unlocks that are saved & loaded
class_name Unlocks

## Contains the weapons, their unlock status, and other stuff
var weapons_unlocked : Dictionary = {
	"rapid": 
		{
			"unlocked": true,
			"item_res": "res://resources/weapon_items_res/rapidItem.tres",
		},
	
	"burstRifle": 
		{
			"unlocked": true,
			"item_res": "res://resources/weapon_items_res/burstRifleItem.tres",
		},
	
	"shotgun": 
		{
			"unlocked": true,
			"item_res": "res://resources/weapon_items_res/shotgunItem.tres",
		},
}
