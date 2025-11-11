extends Button
class_name StoredItemButton

var item : UpgradeItem

var inventory : Inventory

func _ready() -> void:
	icon = item.texture
	
	text = TranslationServer.tr(str(item.name_key_start + "Name"))

func _process(delta: float) -> void:
	pass

func _pressed() -> void:
	if !inventory.current_inv_item:
		inventory.grab_item_from_stored(item)
		queue_free()
