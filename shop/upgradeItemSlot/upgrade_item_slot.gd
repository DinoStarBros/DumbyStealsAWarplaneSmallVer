extends Button
class_name UpgradeItemSlot

var item: Item

@onready var shop : Shop = get_parent().get_parent()
@onready var sprite: Sprite2D = %sprite
@onready var texture: TextureRect = %texture

func _ready() -> void:
	pressed.connect(_on_select)
	
	GlobalSignals.Wave_End.connect(_on_wave_end)

func _on_wave_end() -> void:
	pass

func _on_select() -> void:
	shop.item_selected = self

func _process(_delta: float) -> void:
	pass

func update_visuals() -> void:
	%name.text = str(
		TranslationServer.tr(item.name_key_start + "Name")
	)
	
	%descText.text = str(
		"\n",
		TranslationServer.tr(item.name_key_start + "Desc"),
		"\n",
	)
	
	texture.texture = item.texture
	if item is UpgradeItem:
		%texture.scale = Vector2.ONE
	elif item is WeaponItem:
		%texture.scale = Vector2(2,2)
