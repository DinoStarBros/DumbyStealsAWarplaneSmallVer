extends ColorRect
class_name InventorySlot

func _ready() -> void:
	g.slot_size = roundi(size.x)
