extends Upgrade
class_name RotationSpeedUpgrade

@export var turn_speed_buff : float = 4.0 ## Flat increase to turn speed for the Rotation Component of the player

func apply_player(player: Dumby) -> void:
	player.rotation_component.turn_speed += turn_speed_buff
