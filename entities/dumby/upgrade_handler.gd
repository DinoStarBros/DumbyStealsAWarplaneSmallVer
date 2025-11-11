extends Node2D
class_name UpgradeHandler

@onready var hurtbox_component: HurtboxComponent = %HurtboxComponent
@onready var health_component: HealthComponent = %HealthComponent
@onready var velocity_component: VelocityComponent = %VelocityComponent
@onready var rotation_component: RotationComponent = %RotationComponent

var upgrade_names : Array[String]
@onready var p: Dumby = get_parent()

func _ready() -> void:
	PlayerStats.upgrade_handler = self

func _process(delta: float) -> void:
	%upgrades.text = str(upgrade_names)

func add_upgrade(item: UpgradeItem) -> void:
	var upgrade : UpgradeSCN = item.upgrade_scn.instantiate()
	
	upgrade.item_data = item
	upgrade.global_position = global_position
	
	add_child(upgrade)

func remove_upgrade(item: UpgradeItem) -> void:
	for upgrade : UpgradeSCN in get_children():
		if upgrade.item_data == item:
			upgrade.queue_free()
			break
