extends Resource
class_name WeaponStats

@export var weapon_key : String

@export var shoot_cooldown : float = 0.1 ## The amount of time (in seconds) each shot will take before shooting again
@export var bullet_spd : int = 1500 ## Speed of the bullet
@export var bullet_amnt : int = 1 ## How many bullets will come out per shot
@export var random_spread : float = 0 ## How spread out the bullets will be, recommended for high bulllet amounts like shotgun (Keep it in the tenths(0.1) place, having an integer causes it to go crazy)
@export var bullet_lifetime : float = 1 ## How many seconds before the bullet is deleted
@export var shoot_delay : float = 0 ## The amount of time in between shots if there's multiple bullets per shot
@export var base_damage : float = 5 ## Base daamge given to the bullet

@export var bullet_scn : PackedScene

## Choose which stat to buff by how much when buffed.
## You get buffed when rolling through damage.
@export_category("Stats Buff")
@export var shoot_cooldown_buff : float ## Percent buff (0.5 = 50% buff)
@export var bullet_spd_buff : float ## Percent buff (0.5 = 50% buff)
@export var bullet_amnt_buff : int ## Flat buff (e.g. 1 = +1 extra bullet shot)
@export var random_spread_buff : float ## Percent buff (0.5 = 50% buff)
@export var bullet_lifetime_buff : float ## Flat buff (1.0 = +1 extra second of bullet lifetime)
@export var shoot_delay_buff : float ## Percent buff (0.5 = 50% faster)
@export var damage_buff : float ## Percent buff (0.5 = 50% more damage)
@export var max_ammo_buff : float ## Not sure if I'll be using this shit. DUMBASS
@export var ammo_use_buff : int ## Flat buff (1 = 1 less ammo used per shot)

@export_category("Sound Effects")
@export var single_sfx : Array[WeaponsSFXHandler.weapon_sfx]
@export var multi_sfx : Array[WeaponsSFXHandler.weapon_sfx]
#@export var sfx : Array[WeaponsSFXHandler.weapon_sfx]

@export_category("Muzzle Flash")
@export var muzzle_flashes : Array[WeaponMuzzleFlash.muzzle_flash_types]
