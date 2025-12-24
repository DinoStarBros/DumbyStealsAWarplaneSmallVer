extends Projectile 

var pos_to_look : Vector2

func _ready() -> void:
	look_at(pos_to_look)

func _physics_process(_delta:float)->void:
	%HitboxComponent.set_attack_properties(dmg)

func _on_dur_timeout() -> void:
	queue_free()
