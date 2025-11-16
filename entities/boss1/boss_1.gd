extends Enemy
class_name Boss1

func _ready() -> void:
	GlobalSignals.Boss_Spawned.emit(global_position, 3)

func damage(attack: Attack) -> void:
	pass

func Dead(attack: Attack) -> void:
	GlobalSignals.Boss_Defeated.emit(global_position, 3)
