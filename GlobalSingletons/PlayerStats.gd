extends Node

var percent_damage : float = 0.0
var armor : float = 0
var speed: float = 900
var rotation_speed : float = 4

var money : float = 0

const BASE_DAMAGE_PERCENT : float = 0.0
const BASE_ARMOR : float = 0.0
const BASE_SPD : float = 900
const BASE_ROT_SPD : float = 4

const BASE_MONEY : int = 100

var upgrade_handler : UpgradeHandler

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func add_upgrade(item: ItemData) -> void:
	upgrade_handler.add_upgrade(item)

func remove_upgrade(item: ItemData) -> void:
	upgrade_handler.remove_upgrade(item)
