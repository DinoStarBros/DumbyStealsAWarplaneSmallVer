extends Button
class_name StoredItemButton

var item : ItemData

var inventory : Inventory


func _ready() -> void:
	icon = item.texture
	
	text = item.name

func _process(delta: float) -> void:
	pass

func _pressed() -> void:
	if !inventory.current_inv_item:
		inventory.grab_item_from_stored(item)
		queue_free()
