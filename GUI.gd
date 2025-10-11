extends CanvasLayer

signal NewGun

var are_you_sure : bool = false
@onready var settings_menu: Settings = %settingsMenu
@onready var sp_budget_txt: Label = %sp_budget_txt
@onready var weapons_parent: WeaponsParent = %weapons_parent

func _ready() -> void:
	g.score = 0
	g.killscore = 0
	
	%pause_button.pressed.connect(_on_pausebutton_pressed)
	
	GlobalSignals.Wave_End.connect(_on_wave_end)
	
	await get_tree().create_timer(0).timeout
	_on_wave_end()

func _process(_delta: float) -> void:
	debug_txts()
	
	%joystick.visible = g.mobile
	%yLost.visible = g.game_state == g.game_states.Lost
	
	if Input.is_action_just_pressed("pause"):
		_pause()
	
	%paused.visible = get_tree().paused and g.game_state == g.game_states.Combat
	%sure.visible = are_you_sure
	
	%buffs.text = str(weapons_parent.q_reload_buff_time, " : ",weapons_parent.dodge_buff_time)

func _on_menu_pressed() -> void:
	scene_change("res://game_screens/title/title.tscn")
	get_tree().paused = false
	g.game_state = g.game_states.Title

func scene_change(scene:String)->void:
	SceneManager.change_scene(
		scene, {
			"pattern_enter" : "curtains",
			"pattern_leave" : "fade",
			}
		)

func _on_resume_pressed() -> void:
	get_tree().paused = false
	settings_menu._on_save_pressed()

func newgun_handling() -> void: ## This is old feature, game jam version
	%score.text = str("Score:\n",g.score)
	%"2next".text = str("Kills : \n", g.killscore)
	if g.killscore >= 20:
		%newgunim.play("newgun")
		g.killscore = 0
		emit_signal("NewGun")

func _on_quit_pressed() -> void:
	are_you_sure = not are_you_sure

func _on_sure_pressed() -> void:
	get_tree().paused = true
	scene_change("res://game_screens/title/title.tscn")
	g.game_state = g.game_states.Title
	settings_menu._on_save_pressed()

func _on_pausebutton_pressed() -> void:
	_pause()

func _pause() -> void:
	if not g.game_state == g.game_states.Combat:
		return
	
	get_tree().paused = not get_tree().paused
	are_you_sure = false
	
	if get_tree().paused:
		# pause
		settings_menu._on_load_pressed()
		%resume.grab_focus()
	else:
		# unpause
		settings_menu._on_save_pressed()

func _on_wave_end() -> void:
	%wave_no.text = str("Wave : ", g.wave)

func debug_txts() -> void:
	#%upgrades.text = str(PlayerStats.upgrade_names)
	
	sp_budget_txt.text = str(
		g.spawn_budget.x ," / ",g.spawn_budget.y
	)
	
	%stat_txt.text = str(
		"Percent_Damage: ", PlayerStats.percent_damage, "\n",
		"Max HP: ", PlayerStats.upgrade_handler.health_component.max_hp, "\n",
		"Speed: ", PlayerStats.speed, "\n",
		"Rot Speed: ", PlayerStats.rotation_speed, "\n",
		"Money: ", PlayerStats.money, "\n",
	)
	
	%curr_weap.text = str(weapons_parent.current_weapon.name)
