extends Resource
class_name ItemData

@export var name : String
@export var texture : Texture2D

@export var shape : Array[Array]

@export var color : Color = Color.WHITE

@export var upgrade: Upgrade

var domain : Array[Vector2i]
