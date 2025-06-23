extends Node2D

func _ready() -> void:
	SceneManager.fade_in()
	for n in %buttons.get_children():
		if n is Button:
			n.focus_mode = Control.FOCUS_NONE

func _on_play_pressed() -> void:
	scene_change("res://game_screens/game/game.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func scene_change(scene:String)->void:
	SceneManager.change_scene(
		scene, {
			"pattern_enter" : "circle",
			"pattern_leave" : "fade",
			}
		)
var deltaTime : = 0.0
var sin_val : float
func _process(delta: float) -> void:
	deltaTime += delta
	if deltaTime >= 180:
		deltaTime = 0
	
	sin_val = sin(deltaTime)
	#%buttons.global_position.y += (sin_val * delta) * 20
	%Txt.scale.x = 0.3 + (sin_val * 0.05)
	%Txt.global_position.y += (sin_val * delta) * -5

func _physics_process(_delta: float) -> void:
	settings_menu_handle(-10)

var options_on : bool = false
func _on_options_pressed() -> void:
	options_on = not options_on
	%options.play()
	
	settings_menu._on_load_pressed()
	settings_menu._on_save_pressed()

func _on_about_pressed() -> void:
	pass # Replace with function body.

func _on_credits_pressed() -> void:
	pass # Replace with function body.

@onready var settings_menu: Settings = %settingsMenu
var sm_target_pos : Vector2
func settings_menu_handle(weight : float) -> void:
	if options_on:
		sm_target_pos = Vector2(-620, -300)
	else:
		sm_target_pos = Vector2(-620, 500)
	
	var sm_pos_lerp : Vector2 = settings_menu.position.lerp(sm_target_pos, 1.0 - exp(weight * get_physics_process_delta_time()))
	
	settings_menu.position = sm_pos_lerp
