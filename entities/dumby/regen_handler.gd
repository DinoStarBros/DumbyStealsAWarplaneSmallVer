extends Node
class_name RegenHandler

@onready var health_component: HealthComponent = %HealthComponent
@onready var weapons_parent: WeaponsParent = %weapons_parent
@onready var regen_bar: ProgressBar = %regen_bar
@onready var p : Dumby = get_parent()

### Below is all the stuff for regen ###
var regen_time : float = 0
var max_regen_time : float = 1
var regen_speed : float = .3
var regen_speed_limit : float = 1
var regen_time_mult : float = 0

func regen_handling(delta: float) -> void:
	
	if health_component.hp < health_component.max_hp:
		regen_speed += delta
		regen_time += delta * regen_speed * regen_time_mult
	else:
		regen_time = 0
		regen_speed = 0.5
	
	if regen_speed >= regen_speed_limit:
		regen_speed = regen_speed_limit
	
	if regen_time >= max_regen_time:
		regen_time = 0
		heal()
		%heal.play()
	
	# Regeneration gets slower when shooting and/or accelerating
	if p.shooting and not p.accelerating:
		regen_time_mult = 0.5
	elif p.accelerating and not p.shooting:
		regen_time_mult = 0.5
	elif p.accelerating and p.shooting:
		regen_time_mult = 0.2
	else:
		regen_time_mult = 1

func _on_hurtbox_component_plr_hit(_dmg: int) -> void:
	# Regen speed gets slowed down when hit
	regen_speed = .4

func heal()->void:
	if health_component.hp < health_component.max_hp:
		health_component.hp += 1
		g.spawn_txt("+1 HP!", p.global_position)

func _process(delta: float) -> void:
	if not health_component.hp > 0: # If he ain't alive, stop
		return
	
	if not g.game_state == g.game_states.Combat: # If he aint in combat, no regen
		return
	
	regen_bar.max_value = max_regen_time
	regen_bar.value = regen_time
	
	regen_handling(delta)
	
	regen_bar.visible = health_component.hp < health_component.max_hp and not weapons_parent.current_weapon.reloading
