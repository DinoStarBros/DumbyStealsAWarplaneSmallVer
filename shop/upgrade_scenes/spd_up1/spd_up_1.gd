extends UpgradeSCN

const SPD_BUFF : float = 400

func _ready() -> void:
	PlayerStats.speed += SPD_BUFF

func _exit_tree() -> void:
	PlayerStats.speed -= SPD_BUFF
