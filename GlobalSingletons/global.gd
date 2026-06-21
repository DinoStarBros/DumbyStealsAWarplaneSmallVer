extends Node

var game : Node 
var enemy_container : Node2D
var projectile_container : Node2D
var floor_hitbox : HitboxComponent
var cam : PlrCamera
var camRect : ColorRect
var screen_corners : Rect2
var player : Dumby
var enemy_arrows : Node
var attack : Attack = Attack.new()
var game_state : game_states = g.game_states.Title#: set = new_game_state
var score : int = 0
var killscore : int = 0
var xp : int = 0
var next_lvl_xp : int = 20
var level : int = 1
var mobile : bool = false
var lil_printy : Label
var weapons_parent : WeaponsParent
var wave : int
var current_weapon_button_selected_res : WeaponStats
var sky_enemy_spawner : SkyEnemySpawner

enum game_states {
	Title, Combat, Lost, Upgrade, Cutscene,
}
var gs_strings : Array = [
	"Title", "Combat", "Lost", "Upgrade", "Cutscene"
]
var gs_string : String
const txt_scn : PackedScene = preload("res://scenes/DmgNum/dmg_num.tscn")

var slot_size : float

func spawn_txt(text: String, global_pos: Vector2)->void: ## Spawns a splash text effect, can be used for damage numbers, or score
	var txt : DmgNum = txt_scn.instantiate()
	txt.text = text
	txt.global_position = global_pos
	game.add_child(txt)

func _ready() -> void:
	volume_handle()
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta:float)->void:
	gs_string = gs_strings[game_state]
	volume_handle()

func frame_freeze(timescale: float, duration: float) -> void: ## Slows down the engine's time scale, slowing down the time, for a certain duration. Use for da juice
	if SaveLoad.settings.frame_freeze_value:
		Engine.time_scale = timescale
		await get_tree().create_timer(duration, true, false, true).timeout
		Engine.time_scale = 1.0

func volume_handle() -> void:
	AudioServer.set_bus_volume_db(
		0,
		linear_to_db(SaveLoad.settings.master_volume)
	)
	AudioServer.set_bus_volume_db(
		1,
		linear_to_db(SaveLoad.settings.music_volume)
	)
	AudioServer.set_bus_volume_db(
		2,
		linear_to_db(SaveLoad.settings.sfx_volume)
	)

var spawn_budget : Vector2 ## X is spawn_budget, Y is max_spawn_budget

func scene_change(scene:String)->void:
	SceneManager.change_scene(
		scene, {
			"pattern_enter" : "circle",
			"pattern_leave" : "fade",
			}
		)

var tween : Tween
var property_tween : Object
var tween_ease : Object
## Creates tweens for Nodes for their properties that are Vector2, e.g. Position, Scale
func create_property_vec2_tween(
	node:Node,
	vec2:Vector2, 
	property: String = "position",
	time: float = 1.0,
	set_ease: Tween.EaseType = Tween.EASE_IN_OUT, 
	set_trans: Tween.TransitionType = Tween.TRANS_SPRING
	) -> void:
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	property_tween = tween.tween_property(node, property, vec2, time)
	tween_ease = property_tween.set_ease(set_ease)
	tween_ease.set_trans(set_trans)
