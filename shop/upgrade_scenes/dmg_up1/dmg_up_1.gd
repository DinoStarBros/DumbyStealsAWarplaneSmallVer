extends UpgradeSCN

func _ready() -> void:
	print("APPLY DAMAGE!")

func _exit_tree() -> void:
	print("UNAPPLY DAMAGE!")
