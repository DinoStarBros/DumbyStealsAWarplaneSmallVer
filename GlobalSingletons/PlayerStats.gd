extends Node

var percent_damage : float = 0.0
var armor : float = 0
var speed: float = 900
var rotation_speed : float = 4
var acceleration : float = 4.0
var max_iframes : float = 1.0

var money : float = 0

const BASE_DAMAGE_PERCENT : float = 0.0
const BASE_ARMOR : float = 0.0
const BASE_SPD : float = 900
const BASE_ROT_SPD : float = 10
const BASE_ACCEL : float = 4
const BASE_MAX_IFRAMES : float = 1.0

const BASE_MONEY : int = 100

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
