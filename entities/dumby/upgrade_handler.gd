extends Node2D
class_name UpgradeHandler

@onready var hurtbox_component: HurtboxComponent = %HurtboxComponent
@onready var health_component: HealthComponent = %HealthComponent
@onready var velocity_component: VelocityComponent = %VelocityComponent
@onready var rotation_component: RotationComponent = %RotationComponent

func _ready() -> void:
	PlayerStats.upgrade_handler = self

func _process(delta: float) -> void:
	#%upgrades.text = str()
	pass

func add_upgrade(item: ItemData) -> void:
	var upgrade : UpgradeSCN = item.upgrade_scn.instantiate()
	
	upgrade.item_data = item
	upgrade.global_position = global_position
	
	add_child(upgrade)

func remove_upgrade(item: ItemData) -> void:
	for upgrade : UpgradeSCN in get_children():
		if upgrade.item_data == item:
			upgrade.queue_free()
