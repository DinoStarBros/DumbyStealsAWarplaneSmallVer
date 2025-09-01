extends Upgrade
class_name MissileUpgrade

const rocket_scn : PackedScene = preload(References.projectile_scns["homing_rocket"])
@export var chance_rocket : float = 0.1 ## Chance to shoot a rocket per shot
var p: Dumby

func apply_player(player: Dumby) -> void:
	#if not player.Shoot.is_connected(_on_shoot):
	player.Shoot.connect(_on_shoot)
	
	p = player

func _on_shoot() -> void:
	
	
	
	if randf() < chance_rocket:
		var rocket : Homing_Rocket = rocket_scn.instantiate()
		
		rocket.initial_velocity = p.rotation_component.direction
		
		rocket.dmg = 5
		rocket.dmg = 8
		
		g.projectile_container.add_child(rocket)
		
		rocket.global_position = p.global_position
