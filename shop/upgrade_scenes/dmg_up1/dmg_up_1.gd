extends UpgradeSCN

const DMG_ADDED : float = 0.3

func _ready() -> void:
	PlayerStats.percent_damage += DMG_ADDED

func _exit_tree() -> void:
	PlayerStats.percent_damage -= DMG_ADDED
