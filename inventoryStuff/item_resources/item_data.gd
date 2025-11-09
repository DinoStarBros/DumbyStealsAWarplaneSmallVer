extends Resource
class_name ItemData

@export var name_key : String ##Ex.speedUp1Name, like how the key is named in the csv sheet. camelCase, "Name" at the end
@export var description_key : String ## Ex. speedUp1Desc, like how the key is named in the csv sheet. camelCase, "Desc" at the end
@export var flavor_text_key : String ## Ex. speedUp1Flavor, like how the key is named in the csv sheet. camelCase, "Flavor" at the end

var name : String
var description : String
var flavor_text : String
@export var texture : Texture2D
@export var buy_price : float = 0

@export var shape : Array[Array]

@export var color : Color = Color.WHITE

@export var upgrade_scn: PackedScene

var domain : Array[Vector2i]
