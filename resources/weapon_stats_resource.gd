extends Resource
class_name WeaponStats

@export var shoot_cooldown : float = 0.1 ## The amount of time (in seconds) each shot will take before shooting again
@export var bullet_spd : int = 1500 ## Speed of the bullet
@export var bullet_amnt : int = 1 ## How many bullets will come out per shot
@export var random_spread : float = 0 ## How spread out the bullets will be, recommended for high bulllet amounts like shotgun (Keep it in the tenths(0.1) place, having an integer causes it to go crazy)
@export var bullet_lifetime : float = 1 ## How many secondes before the bulet is deleted
@export var shoot_delay : float = 0 ## The amount of time in between shots if there's multiple bullets per shot
@export var base_damage : int = 5 ## Base daamge given to the bullet

@export var bullet_scn : PackedScene

@export var max_ammo : int = 10 ## Max amount of ammo
@export var ammo_use : int = 1 ## Amount of ammo that gets used up per shot

@export var max_reload_duration : float = 1 ## The time it takes to reload said weapon
@export var min_sweet_spot : float = 0.5 ## The minimum time you can do a tactical reload (IT'S VERY IMPORTANT THAT IT'S KEPT LOWER THAN THE MAX RELOAD DURATION AND HIGHER THAN 0)
@export var max_sweet_spot : float = 0.6 ## The maximum time you can do a tactical reload (IT'S VERY IMPORTANT THAT IT'S KEPT LOWER THAN THE MAX RELOAD DURATION AND HIGHER THAN 0)

@export var max_buff_time : float = 0 ## The amount of time the weapon gets buffed after tactical reloading, before going back to normal
