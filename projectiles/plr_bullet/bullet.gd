extends Projectile

@onready var hitbox_component: HitboxComponent = %HitboxComponent

func _ready() -> void:
	hitbox_component.set_attack_properties(dmg)
