extends Node2D
class_name WeaponsParent

@export var dumby : Dumby
@export var ammo_bar : ProgressBar
var ammo_text : Label
var current_weapon : Weapon
var weapons : Array
var current_weapon_idx : int

@onready var regen_bar: ProgressBar = %regen_bar
@onready var health_component: HealthComponent = %HealthComponent
@onready var reload_bar: ProgressBar = %reload_bar
@onready var max_ss_vis: ProgressBar = %max_ss_vis
@onready var min_ss_vis: ProgressBar = %min_ss_vis
@onready var p : Dumby = get_parent() ## Reference to the Parent Node, Dumby

func _ready() -> void:
	ammo_text = ammo_bar.get_child(0)
	for weapon in get_children():
		if weapon is Weapon:
			weapons.append(weapon)
			current_weapon = weapon

func _process(delta: float) -> void:
	current_weapon_idx = weapons.find(current_weapon)
	
	look_at(p.dir_plane + global_position)
	regen_bar.visible = health_component.hp < health_component.max_hp and not current_weapon.reloading
	ammo_handling(delta)
	reload_bar.visible = current_weapon.reloading
	max_ss_vis.visible = current_weapon.reloading
	min_ss_vis.visible = current_weapon.reloading
	
	regen_handling.call(delta)
	regen_bar.max_value = max_regen_time
	regen_bar.value = regen_time
	
	if not current_weapon.reloading:
		if Input.is_action_pressed("shoot") and current_weapon.ammo > 0:
			%flashnim.play("flash")
			#regen_time = 0
			#regen_speed = 0.5
		#else:
		#	
		#	
		if not p.shooting:
			if Input.is_action_just_pressed("next_weapon"):
				switch_weapon(1)
			
			if Input.is_action_just_pressed("prev_weapon"):
				switch_weapon(-1)

### Below is stuff for ammo counts and reloading ###
var reload_time : float = 0 ## The amount of time that has passed since the start of the reload
func ammo_handling(delta: float) -> void:
	ammo_bar.max_value = current_weapon.stats.max_ammo
	ammo_bar.value = current_weapon.ammo
	
	ammo_text.text = str(current_weapon.ammo, " / ", current_weapon.stats.max_ammo)
	
	ammo_bar.visible = current_weapon.ammo > 0
	
	if current_weapon.ammo <= 0:
		if not current_weapon.reloading:
			%reload.pitch_scale = randf_range(1.1,1.3)
			%reload.play()
			
			%reload2.pitch_scale = randf_range(1.5,1.7)
			%reload2.play(1.2)
			
			current_weapon.r_tact_pressed = false
			reload_time = 0
			reload_bar.max_value = current_weapon.stats.max_reload_duration
			current_weapon.reloading = true
			
			max_ss_vis.max_value = current_weapon.stats.max_reload_duration
			min_ss_vis.max_value = current_weapon.stats.max_reload_duration
			
			max_ss_vis.value = current_weapon.stats.max_sweet_spot - 0.05
			min_ss_vis.value = current_weapon.stats.min_sweet_spot
	
	if current_weapon.reloading:
		reload_time += delta
		reload_bar.value = reload_time
		
		if reload_time >= current_weapon.stats.max_reload_duration: 
			# Finished reloading
			finished_reload()
			current_weapon.buff_time = 0
		
		if Input.is_action_just_pressed("shoot") and not current_weapon.r_tact_pressed:
			# Handling of tactical reloading
			current_weapon.r_tact_pressed = true
			if reload_time > current_weapon.stats.min_sweet_spot and reload_time < current_weapon.stats.max_sweet_spot:
				g.spawn_txt("Quick Reload", global_position)
				tactical_reload()
			else:
				# Failed tactical reload
				%reloadfail.pitch_scale = randf_range(0.8, 1)
				%reloadfail.play()
				g.spawn_txt("Womp Womp", global_position)
				current_weapon.buff_time = 0
		
	else:
		reload_time = 0

### Below is all the stuff for regen ###
var regen_time : float = 0
var max_regen_time : float = 1
var regen_speed : float = .3
var regen_speed_limit : float = 1
var regen_time_mult : float = 0
# Goofy lmbda function stuff
var regen_handling : Callable = func(delta: float) -> void:
	
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
	
	if p.shooting and not p.accelerating:
		regen_time_mult = 0.5
	elif p.accelerating and not p.shooting:
		regen_time_mult = 0.5
	elif p.accelerating and p.shooting:
		regen_time_mult = 0.2
	else:
		regen_time_mult = 1

func _on_hurtbox_component_plr_hit(_dmg: int) -> void:
	regen_speed = .4

func heal()->void:
	if health_component.hp < health_component.max_hp:
		health_component.hp += 1
		g.spawn_txt("+1 HP!", global_position)

func finished_reload() -> void:
	p.Reload.emit()
	current_weapon.reloading = false
	current_weapon.ammo = current_weapon.stats.max_ammo

func tactical_reload() -> void:
	p.Quick_Reload.emit()
	%tactical_reload_fx.rotation_degrees = randf_range(-180, 180)
	%shing.pitch_scale = randf_range(0.8, 1.2)
	%shing.play()
	%tactical_reloadnim.play("zing")
	current_weapon.buff_time = current_weapon.stats.max_buff_time
	finished_reload()

func _on_evade_box_perfect_roll() -> void:
	g.spawn_txt("Dodge!", global_position)
	%tactical_reload_fx.rotation_degrees = randf_range(-180, 180)
	%shing.pitch_scale = randf_range(0.8, 1.2)
	%shing.play()
	%tactical_reloadnim.play("zing")
	current_weapon.buff_time = current_weapon.stats.max_buff_time

func switch_weapon(step: int) -> void:
	%switch.pitch_scale = randf_range(1.5, 1.7)
	%switch.play(0.13)
	
	var new_weapon : Weapon
	
	if current_weapon_idx + step > weapons.size() - 1:
		new_weapon = weapons[0]
	elif current_weapon_idx + step < 0:
		new_weapon = weapons[weapons.size() - 1]
	else:
		new_weapon = weapons[current_weapon_idx + step]
	
	current_weapon = new_weapon
