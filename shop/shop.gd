extends Control
class_name Shop

@onready var p : WaveUpgradeUI = get_parent()
var player : Dumby

var upgrade_selected : UpgradeItemSlot
var upgrade_slots : Array

var possible_upgrades : Array

func _ready() -> void:
	# Signal connections
	GlobalSignals.Wave_End.connect(_on_wave_end)
	
	%skip.pressed.connect(_on_skip_pressed)
	%reroll.pressed.connect(_on_reroll_pressed)
	%select.pressed.connect(_on_select_pressed)
	
	upgrade_slots = %upgradeItemSlots.get_children()
	
	possible_upgrades = References.upgrades_res

func _on_skip_pressed() -> void:
	if p.allow_upgrade_end:
		GlobalSignals.Upgrade_End.emit()

func _on_reroll_pressed() -> void:
	if p.allow_upgrade_end:
		pass

func _on_select_pressed() -> void:
	if p.allow_upgrade_end:
		buy()

func _on_wave_end() -> void:
	%select.grab_focus()
	upgrade_selected = null
	
	possible_upgrades.shuffle()
	
	var n : int = -1
	for slot in upgrade_slots:
		if slot is UpgradeItemSlot:
			n += 1
			assign_upgrade_slot(slot, n)

func _process(delta: float) -> void:
	if not g.game_state == g.game_states.Upgrade:
		return
	
	if upgrade_selected:
		%upgradeDesc.text = str(
			upgrade_selected.upgrade.flavor_text
		)
		%upgradeDesc.visible = true
	else:
		%upgradeDesc.visible = false
	
	var sh_desired_pos : Vector2
	if upgrade_selected:
		sh_desired_pos = (
		upgrade_selected.position + Vector2(100, 205)
		)
	else:
		sh_desired_pos = Vector2(-400, 205)
	
	%select_highlight.position = lerp(
		%select_highlight.position, sh_desired_pos, 12.0 * delta
	)

func assign_upgrade_slot(slot: UpgradeItemSlot, ndex: int) -> void:
	slot.upgrade = possible_upgrades[ndex]
	slot.update_visuals()

func buy() -> void:
	upgrade_selected.upgrade.apply_player(player)
	GlobalSignals.Upgrade_End.emit()
