extends UpgradeSCN

const rocket_scn: PackedScene = preload(References.projectile_scns["homing_rocket"])

func _ready() -> void:
	upgrade_handler.p.Hurt.connect(_on_hurt)

func _exit_tree() -> void:
	upgrade_handler.p.Hurt.disconnect(_on_hurt)

func _on_hurt(attack: Attack) -> void:
	call_deferred("_spawn_rocket")

func _spawn_rocket() -> void:
	var rocket : Homing_Rocket = rocket_scn.instantiate()
	rocket.initial_velocity = upgrade_handler.p.rotation_component.direction + Vector2(
		randf_range(-0.3, 0.3), randf_range(-0.3, 0.3)
		)
	
	rocket.dmg = 3
	
	g.projectile_container.add_child(rocket)
	
	rocket.global_position = upgrade_handler.p.global_position
