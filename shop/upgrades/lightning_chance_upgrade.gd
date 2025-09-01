extends Upgrade
class_name LightningChanceUpgrade

@export var chance_lightning : float = 0.2 ## Percent chance to shoot lightning
var p: Dumby

func apply_player(player: Dumby) -> void:
	player.Shoot.connect(_on_shoot)
	
	p = player

func _on_shoot() -> void:
	if randf() < 0.2:
		print("LIGHTNING")
