extends Projectile

@onready var hitbox_component: HitboxComponent = %HitboxComponent

func _ready() -> void:
	hitbox_component.set_attack_properties(dmg)

var time : float = 0
func _physics_process(delta:float)->void:
	time += delta
	if time >= lifetime:
		queue_free()
