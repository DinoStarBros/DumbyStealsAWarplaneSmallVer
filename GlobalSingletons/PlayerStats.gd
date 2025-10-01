extends Node

var percent_damage : float = 0.0
var armor : float = 0
var max_hp: float = 15
var speed: float = 900
var rotation_speed : float = 4

var money : float = 0

const BASE_DAMAGE_PERCENT : float = 0.0
const BASE_MAX_HP : float = 15.0
const BASE_MONEY : int = 100

var upgrade_handler : UpgradeHandler

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func add_upgrade(item: ItemData) -> void:
	upgrade_handler.add_upgrade(item)

func remove_upgrade(item: ItemData) -> void:
	upgrade_handler.remove_upgrade(item)
