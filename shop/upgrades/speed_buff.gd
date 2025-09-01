extends Upgrade
class_name SpeedUpgrade

@export var speed_upgrade : float = 200 ## Flat extra speed for the player's Velocity Component

func apply_player(player: Dumby) -> void:
	player.velocity_component.max_speed += speed_upgrade
