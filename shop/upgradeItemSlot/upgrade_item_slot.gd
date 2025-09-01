extends Button
class_name UpgradeItemSlot

@onready var shop : Shop = get_parent().get_parent()
var upgrade : Upgrade

func _ready() -> void:
	pressed.connect(_on_select)
	
	GlobalSignals.Wave_End.connect(_on_wave_end)

func _on_wave_end() -> void:
	pass

func _on_select() -> void:
	shop.upgrade_selected = self

func _process(_delta: float) -> void:
	pass

func update_visuals() -> void:
	%name.text = str(
		upgrade.name
	)
	
	%descText.text = str(
		"\n",
		upgrade.description
	)
