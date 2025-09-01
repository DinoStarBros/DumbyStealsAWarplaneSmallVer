extends Upgrade
class_name DamageUpgrade

@export var damage_buff : float = 0.2 ## Percent damage buff

func apply_player(player: Dumby) -> void:
	player.percent_damage_buff += damage_buff
