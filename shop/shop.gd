extends Control
class_name Shop

@onready var p : WaveUpgradeUI = get_parent().get_parent()

var upgrade_bought : UpgradeItem = load("res://inventoryStuff/upgrade_item_res/UpgradeBought.tres")
var weapon_bought : WeaponItem = load("res://resources/weapon_items_res/WeaponBought.tres")

var player : Dumby

var item_selected : UpgradeItemSlot
var upgrade_slots : Array

var possible_upgrades : Array
var possible_items : Array

var reroll_cost : int = 5

func _ready() -> void:
	# Signal connections
	GlobalSignals.Wave_End.connect(_on_wave_end)
	
	%next_wave.pressed.connect(_on_nextWave_pressed)
	%reroll.pressed.connect(_on_reroll_pressed)
	%select.pressed.connect(_on_select_pressed)
	%buy.pressed.connect(_on_buy_pressed)
	
	# Gets a reference to all the Item Slots
	upgrade_slots = %upgradeItemSlots.get_children()
	
	possible_items = References.items_res + References.weapon_items_res

func _on_nextWave_pressed() -> void:
	if p.allow_upgrade_end:
		GlobalSignals.Upgrade_End.emit()

func _on_reroll_pressed() -> void:
	if p.allow_upgrade_end and PlayerStats.money >= reroll_cost:
		reroll()

func _on_select_pressed() -> void:
	if p.allow_upgrade_end:
		if item_selected:
			buy()

func _on_buy_pressed() -> void:
	if p.allow_upgrade_end:
		if item_selected:
			if item_selected.item is UpgradeItem:
				if item_selected.item.name_key_start != upgrade_bought.name_key_start:
					add_item_to_inventory(item_selected.item)
			elif item_selected.item is WeaponItem:
				if item_selected.item.name_key_start != weapon_bought.name_key_start:
					add_weapon_to_arsenal(item_selected.item)

func _on_wave_end() -> void:
	%reroll.grab_focus()
	item_selected = null
	
	possible_items.shuffle()
	
	var n : int = -1
	for slot in upgrade_slots:
		if slot is UpgradeItemSlot:
			n += 1
			assign_upgrade_slot(slot, n)

func _process(delta: float) -> void:
	if not g.game_state == g.game_states.Upgrade:
		return
	
	if item_selected:
		%upgradeDesc.text = str(
			TranslationServer.tr(item_selected.item.name_key_start + "Flavor")
		)
		#%upgradeDesc.visible = true
	else:
		#%upgradeDesc.visible = false
		%upgradeDesc.text = (
			"Pick an upgrade"
		)
	
	var sh_desired_pos : Vector2
	if item_selected:
		sh_desired_pos = (
		item_selected.global_position + Vector2(100, 120)
		)
	else:
		sh_desired_pos = Vector2(-400, 120)
	
	%select_highlight.position = lerp(
		%select_highlight.position, sh_desired_pos, 12.0 * delta
	)
	
	%reroll.text = str("Reroll (", reroll_cost, ")")
	%gold.text = str("Money: ", PlayerStats.money)

func assign_upgrade_slot(slot: UpgradeItemSlot, ndex: int) -> void:
	if possible_items[ndex] is Item:
		slot.item = possible_items[ndex]
	slot.update_visuals()

func buy() -> void:
	var upgrade : Upgrade = item_selected.upgrade
	
	upgrade.apply_player(player)
	player.upgrades.append(upgrade)
	player.upgrade_names.append(upgrade.name)
	GlobalSignals.Upgrade_End.emit()
	
	possible_upgrades.remove_at(possible_upgrades.find(upgrade))

const reroll_time : float = 0.5
func reroll() -> void:
	PlayerStats.money -= reroll_cost
	
	reroll_cost += 2
	
	item_selected = null
	
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

func add_item_to_inventory(item: UpgradeItem) -> void:
	g.inventory.add_item_to_storage(item)
	
	item_selected.item = upgrade_bought
	item_selected.update_visuals()

func add_weapon_to_arsenal(item: WeaponItem) -> void:
	g.weapons_parent.add_weapon(item)
	
	item_selected.item = weapon_bought
	item_selected.update_visuals()
