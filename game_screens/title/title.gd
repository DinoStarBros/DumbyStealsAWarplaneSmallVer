extends Node2D

enum menu_mode {
	None, Options, About, Credits
}
var current_menu_mode : menu_mode = menu_mode.None

func _ready() -> void:
	
	get_tree().paused = false
	%play.grab_focus()
	SceneManager.fade_in()
	
	MusicManager.play_song("title")

func _on_play_pressed() -> void:
	g.scene_change("res://game_screens/level_and_weapon_select/level_and_weapon_select.tscn")
	settings_menu._on_save_pressed()

func _on_quit_pressed() -> void:
	settings_menu._on_save_pressed()
	get_tree().quit()

var deltaTime : = 0.0
var sin_val : float
func _process(delta: float) -> void:
	
	deltaTime += delta
	if deltaTime >= 180:
		deltaTime = 0
	
	sin_val = sin(deltaTime)
	#%buttons.global_position.y += (sin_val * delta) * 20
	%Txt.scale.x = 0.3 + (sin_val * 0.04)
	%Txt.global_position.y += (sin_val * delta) * -5

func _physics_process(_delta: float) -> void:
	settings_menu_handle(-10)
	about_menu_handle(-10)
	credits_menu_handle(-10)

func _on_options_pressed() -> void:
	if current_menu_mode == menu_mode.Options:
		current_menu_mode = menu_mode.None
	else:
		current_menu_mode = menu_mode.Options
	%options.play()
	
	if current_menu_mode == menu_mode.Options:
		settings_menu._on_load_pressed()
	else:
		settings_menu._on_save_pressed()

func _on_about_pressed() -> void:
	if current_menu_mode == menu_mode.About:
		current_menu_mode = menu_mode.None
	else:
		current_menu_mode = menu_mode.About

func _on_credits_pressed() -> void:
	if current_menu_mode == menu_mode.Credits:
		current_menu_mode = menu_mode.None
	else:
		current_menu_mode = menu_mode.Credits

const menu_on_pos : Vector2 = Vector2(-620, -300)
const menu_off_pos : Vector2 = Vector2(-620, 500)

@onready var settings_menu: Settings = %settingsMenu
var sm_target_pos : Vector2
func settings_menu_handle(weight : float) -> void:
	if current_menu_mode == menu_mode.Options:
		sm_target_pos = menu_on_pos
	else:
		sm_target_pos = menu_off_pos
	var sm_pos_lerp : Vector2 = settings_menu.position.lerp(sm_target_pos, 1.0 - exp(weight * get_physics_process_delta_time()))
	settings_menu.position = sm_pos_lerp

@onready var about_menu: Control = %aboutMenu
var am_target_pos : Vector2
func about_menu_handle(weight : float) -> void:
	if current_menu_mode == menu_mode.About:
		am_target_pos = menu_on_pos
	else:
		am_target_pos = menu_off_pos
	var am_pos_lerp : Vector2 = about_menu.position.lerp(am_target_pos, 1.0 - exp(weight * get_physics_process_delta_time()))
	about_menu.position = am_pos_lerp

@onready var credits_menu: Control = %creditsMenu
var cm_target_pos : Vector2
func credits_menu_handle(weight : float) -> void:
	if current_menu_mode == menu_mode.Credits:
		cm_target_pos = menu_on_pos
	else:
		cm_target_pos = menu_off_pos
	var cm_pos_lerp : Vector2 = credits_menu.position.lerp(cm_target_pos, 1.0 - exp(weight * get_physics_process_delta_time()))
	credits_menu.position = cm_pos_lerp
