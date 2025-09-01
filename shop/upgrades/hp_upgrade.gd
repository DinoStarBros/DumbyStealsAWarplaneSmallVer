extends Upgrade
class_name HpUpgrade

@export var hp_increase : int = 3 ## Flat hp increase for the player's Health Component

func apply_player(player: Dumby) -> void:
	player.health_component.max_hp += hp_increase
	player.health_component.hp += hp_increase
