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
		reroll()

func _on_select_pressed() -> void:
	if p.allow_upgrade_end:
		if upgrade_selected:
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
		#%upgradeDesc.visible = true
	else:
		#%upgradeDesc.visible = false
		%upgradeDesc.text = (
			"Pick an upgrade"
		)
	
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
	var upgrade : Upgrade = upgrade_selected.upgrade
	
	upgrade.apply_player(player)
	player.upgrades.append(upgrade)
	player.upgrade_names.append(upgrade.name)
	GlobalSignals.Upgrade_End.emit()
	
	possible_upgrades.remove_at(possible_upgrades.find(upgrade))

const reroll_time : float = 0.5
func reroll() -> void:
	
	upgrade_selected = null
	
	_create_property_gpos_tween(
		%upgradeItemSlots, Vector2(0, 1000), reroll_time
		)
	await get_tree().create_timer(reroll_time).timeout
	_on_wave_end()
	
	_create_property_gpos_tween(
		%upgradeItemSlots, Vector2(0, 55), reroll_time
	)

var tween : Tween
var property_tween : Object
var tween_ease : Object
func _create_property_gpos_tween(
	node:Node,
	global_pos:Vector2, 
	time:float=1.0,
	set_ease:Tween.EaseType=Tween.EASE_IN_OUT, 
	set_trans:Tween.TransitionType=Tween.TRANS_SPRING
	) -> void:
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	property_tween = tween.tween_property(node, "position", global_pos, time)
	tween_ease = property_tween.set_ease(set_ease)
	tween_ease.set_trans(set_trans)
