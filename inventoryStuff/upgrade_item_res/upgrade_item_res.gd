extends Item
class_name UpgradeItem

@export var buy_price : float = 0

@export var shape : Array[Array]

@export var color : Color = Color.WHITE

@export var upgrade_scn: PackedScene

var domain : Array[Vector2i]
