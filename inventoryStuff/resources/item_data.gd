extends Resource
class_name ItemData

@export var name : String
@export var description : String
@export var texture : Texture2D
@export var buy_price : float = 0

@export var shape : Array[Array]

@export var color : Color = Color.WHITE

@export var upgrade_scn: PackedScene

var domain : Array[Vector2i]
