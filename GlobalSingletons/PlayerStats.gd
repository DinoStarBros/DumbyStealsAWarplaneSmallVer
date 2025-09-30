extends Node

var damage_percent : float = 0.0
var armor : float = 0

var money : float = 0

var upgrades : Array[Upgrade]
var upgrade_names : Array[String]

const BASE_DAMAGE_PERCENT : float = 0.0
const BASE_MAX_HP : float = 15.0

func add_upgrade(upgrade: Upgrade) -> void:
	upgrade.apply_player(g.player)
	upgrade_names.append(upgrade.name)

func remove_upgrade() -> void:
	pass
