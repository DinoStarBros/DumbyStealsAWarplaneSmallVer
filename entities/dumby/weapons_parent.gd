extends Node2D
class_name WeaponsParent

@export var dumby : Dumby
@export var ammo_bar : ProgressBar

var ammo_text : Label
var current_weapon : Weapon
var weapons : Array
var current_weapon_idx : int

var q_reload_buff_time : float = 0
var max_q_reload_buff_time : float = 5
var dodge_buff_time : float = 0
var max_dodge_buff_time : float = 3
var q_reload_buffed : bool = false
var dodge_buffed : bool = false

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
	ammo_handling(delta)
	reload_bar.visible = current_weapon.reloading
	max_ss_vis.visible = current_weapon.reloading
	min_ss_vis.visible = current_weapon.reloading
	
	q_reload_buff_time = max(0, q_reload_buff_time - delta)
	dodge_buff_time = max(0, dodge_buff_time - delta)
	
	q_reload_buffed = q_reload_buff_time > 0
	dodge_buffed = dodge_buff_time > 0
	
	if p.shooting:
		
		%flashnim.play("flash")
		
	else:
		
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
		
	else:
		reload_time = 0

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
	finished_reload()
	
	#current_weapon.buff_time = current_weapon.stats.max_buff_time
	q_reload_buff_time = max_q_reload_buff_time

func _on_evade_box_perfect_roll() -> void:
	g.spawn_txt("Dodge!", global_position)
	%tactical_reload_fx.rotation_degrees = randf_range(-180, 180)
	%shing.pitch_scale = randf_range(0.8, 1.2)
	%shing.play()
	%tactical_reloadnim.play("zing")
	
	#current_weapon.buff_time = current_weapon.stats.max_buff_time
	dodge_buff_time = max_dodge_buff_time

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
