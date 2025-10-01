extends UpgradeSCN

const ROTATION_SPEED_BUFF : float = 3

func _ready() -> void:
	PlayerStats.rotation_speed += ROTATION_SPEED_BUFF

func _exit_tree() -> void:
	PlayerStats.rotation_speed -= ROTATION_SPEED_BUFF
