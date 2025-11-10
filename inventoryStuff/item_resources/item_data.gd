extends Resource
class_name ItemData

@export var name_key_start : String ##Ex.speedUp1, then it'll add "Name" "Desc" "Flavor" at the end to match the key in the .csv

var name : String
var description : String
var flavor_text : String
@export var texture : Texture2D
@export var buy_price : float = 0

@export var shape : Array[Array]

@export var color : Color = Color.WHITE

@export var upgrade_scn: PackedScene

var domain : Array[Vector2i]
