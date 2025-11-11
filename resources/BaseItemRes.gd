extends Resource
## The base item resource, just to organize
## The WeaponItem and UpgradeItem
class_name Item

@export var name_key_start : String ##Ex.speedUp1, then it'll add "Name" "Desc" "Flavor" at the end to match the key in the .csv
@export var texture : Texture2D
