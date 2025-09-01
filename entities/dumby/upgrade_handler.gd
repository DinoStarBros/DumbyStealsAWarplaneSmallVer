extends Node2D
class_name UpgradeHandler

@onready var hurtbox_component: HurtboxComponent = %HurtboxComponent
@onready var health_component: HealthComponent = %HealthComponent
@onready var velocity_component: VelocityComponent = %VelocityComponent
@onready var rotation_component: RotationComponent = %RotationComponent

func _ready() -> void:
	pass

var upgrades : Array[Upgrade] = []
