extends Control
class_name Shop

@onready var p : WaveUpgradeUI = get_parent().get_parent()

var item_bought : ItemData = load("res://inventoryStuff/item_resources/ItemBought.tres")

var player : Dumby

var upgrade_selected : UpgradeItemSlot
var upgrade_slots : Array

var possible_upgrades : Array
var possible_items : Array

var reroll_cost : int = 5

func _ready() -> void:
	# Signal connections
	GlobalSignals.Wave_End.connect(_on_wave_end)
	
	%skip.pressed.connect(_on_skip_pressed)
	%reroll.pressed.connect(_on_reroll_pressed)
	%select.pressed.connect(_on_select_pressed)
	%buy.pressed.connect(_on_buy_pressed)
	
	upgrade_slots = %upgradeItemSlots.get_children()
	
	possible_items = References.items_res

func _on_skip_pressed() -> void:
	if p.allow_upgrade_end:
		GlobalSignals.Upgrade_End.emit()

func _on_reroll_pressed() -> void:
	if p.allow_upgrade_end and PlayerStats.money >= reroll_cost:
		reroll()

func _on_select_pressed() -> void:
	if p.allow_upgrade_end:
		if upgrade_selected:
			buy()

func _on_buy_pressed() -> void:
	if p.allow_upgrade_end:
		if upgrade_selected:
			if upgrade_selected.item.name != item_bought.name:
				add_item_to_inventory()

func _on_wave_end() -> void:
	%reroll.grab_focus()
	upgrade_selected = null
	
	possible_upgrades.shuffle()
	possible_items.shuffle()
	
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
			upgrade_selected.item.flavor_text
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
		upgrade_selected.global_position + Vector2(100, 120)
		)
	else:
		sh_desired_pos = Vector2(-400, 120)
	
	%select_highlight.position = lerp(
		%select_highlight.position, sh_desired_pos, 12.0 * delta
	)
	
	%reroll.text = str("Reroll (", reroll_cost, ")")
	%gold.text = str("Money: ", PlayerStats.money)

func assign_upgrade_slot(slot: UpgradeItemSlot, ndex: int) -> void:
	#slot.upgrade = possible_upgrades[ndex]
	slot.item = possible_items[ndex]
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
	PlayerStats.money -= reroll_cost
	
	reroll_cost += 2
	
	upgrade_selected = null
	
	_create_property_gpos_tween(
		%upgradeItemSlots, Vector2(130, 1000), reroll_time
		)
	
	%reroll.hide()
	await get_tree().create_timer(reroll_time).timeout
	_on_wave_end()
	
	%reroll.show()
	_create_property_gpos_tween(
		%upgradeItemSlots, Vector2(130, 115), reroll_time
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

func add_item_to_inventory() -> void:
	g.inventory.add_item_to_storage(upgrade_selected.item)
	
	upgrade_selected.item = item_bought
	upgrade_selected.update_visuals()
