extends UpgradeSCN

const rocket_scn:PackedScene = preload(References.projectile_scns["homing_rocket"])
const chance : float = 0.5

func _ready() -> void:
	upgrade_handler.p.Shoot.connect(_on_shoot)

func _exit_tree() -> void:
	pass

func _on_shoot() -> void:
	if randf() < chance:
		_spawn_rocket()

func _spawn_rocket() -> void:
	var rocket : Homing_Rocket = rocket_scn.instantiate()
	rocket.initial_velocity = upgrade_handler.p.rotation_component.direction
	rocket.global_position = global_position
	
	g.projectile_container.add_child(rocket)
	
