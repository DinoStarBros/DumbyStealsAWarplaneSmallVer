extends Node2D
class_name Weapon

@export var stats : WeaponStats

@onready var p : Dumby = owner

var can_shoot : bool = true
var cooldown : float = 0

var dir_to_mouse : Vector2 ## Normalized direction vector from the player to the mouse
#var dist_to_mouse : float ## Distance from the player to the mouse
var rand_spread_vector : Vector2

var ammo : int

var reloading : bool = false ## Checks if the weapon is reloading, if so, it disables shooting

var r_tact_pressed : bool = false

var buff_time : float = 0 ## The amount of time that has passed since the buff, weapon goes back to normal once it reaches 0
var buffed : bool = false

func _ready() -> void:
	pass
