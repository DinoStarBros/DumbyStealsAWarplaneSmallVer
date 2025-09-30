extends Resource
class_name Upgrade

@export var name : String
@export var description : String
@export var flavor_text : String

@export var buy_price : int
@export var sell_price : int

var amount : int = 1 ## How many there are of the same upgrade
func apply_player(player: Dumby) -> void:
	pass

func unapply_upgrade(player: Dumby) -> void:
	pass
