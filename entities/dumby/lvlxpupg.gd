extends CanvasLayer
class_name WaveUpgradeUI
# The script for handling shop upgrades in between waves

var allow_upgrade_end : bool = false

@onready var shop : Shop = %shop
@onready var player : Dumby = get_parent()
@onready var shopninv: TabContainer = %shopninv

func _ready() -> void:
	GlobalSignals.Wave_End.connect(_on_wave_end)
	GlobalSignals.Upgrade_End.connect(_on_upgrade_end)
	
	%shop.player = player

func _on_wave_end() -> void: # End of wave, start upgrade
	
	await get_tree().create_timer(0.5).timeout
	
	shop.reroll_cost = 5
	shopninv.current_tab = 0
	
	_create_property_gpos_tween(shopninv, Vector2(0, 0), 0.7)
	
	g.game_state = g.game_states.Upgrade
	get_tree().paused = true
	
	await get_tree().create_timer(0.7).timeout
	
	allow_upgrade_end = true

func _on_upgrade_end() -> void: # After selecting / skipping upgrade
	_create_property_gpos_tween(shopninv, Vector2(0, 900), 0.5)
	
	allow_upgrade_end = false
	
	await get_tree().create_timer(0.6).timeout
	
	g.game_state = g.game_states.Combat
	get_tree().paused = false

func _unhandled_input(_event: InputEvent) -> void:
	pass

func _process(_delta: float) -> void:
	pass

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
