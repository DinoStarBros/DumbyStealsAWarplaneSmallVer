extends Upgrade
class_name MissileUpgrade

const missile_scn : PackedScene = preload(References.projectile_scns["homing_rocket"])
@export var chance_missile : float = 0.1 ## Chance to shoot a missile per shot

func apply_player(player: Dumby) -> void:
	pass
