extends Projectile

@onready var hitbox_component: HitboxComponent = %HitboxComponent

func _ready() -> void:
	hitbox_component.Hit.connect(hit)
	%Sparticle.amount = randi_range(10, 30)

var time : float = 0
func _physics_process(delta:float)->void:
	hitbox_component.set_attack_properties(dmg)
	time += delta
	if time >= lifetime:
		queue_free()

func hit() -> void:
	%Sparticle.rotation_degrees += 180
	velocity = Vector2.ZERO
	#g.cam.screen_shake(7, 0.1)
	%anim.play("hit")
