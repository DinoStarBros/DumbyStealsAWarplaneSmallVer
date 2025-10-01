extends UpgradeSCN

const HP_BUFF : float = 5

func _ready() -> void:
	upgrade_handler.health_component.max_hp += HP_BUFF
	upgrade_handler.health_component.hp += HP_BUFF

func _exit_tree() -> void:
	upgrade_handler.health_component.max_hp -= HP_BUFF
	
	if upgrade_handler.health_component.hp > upgrade_handler.health_component.max_hp:
		upgrade_handler.health_component.hp = upgrade_handler.health_component.max_hp
