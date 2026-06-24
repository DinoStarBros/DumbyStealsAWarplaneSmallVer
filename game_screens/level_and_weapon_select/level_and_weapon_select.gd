extends Control
class_name LevelAndWeaponSelect

@onready var return_button: Button = %return_button
@onready var weapon_parts_select_button: Button = %weapon_parts_select_button
@onready var level_buttons : Dictionary = {
	1: [
		%"l1-1",
		(preload("res://resources/LevelResources/1-1.tres"))
	],
	2: [
		%"l1-2",
		(preload("res://resources/LevelResources/1-2.tres"))
	],
	3: [
		%"l1-3",
		(preload("res://resources/LevelResources/1-3.tres"))
	],
	4: [
		%"l1-4",
		(preload("res://resources/LevelResources/1-4.tres"))
	],
	5: [
		%"l1-5",
		(preload("res://resources/LevelResources/1-5.tres"))
	],
	6: [
		%"l1-6",
		(preload("res://resources/LevelResources/1-6.tres"))
	],
	7: [
		%"l1-7",
		(preload("res://resources/LevelResources/1-7.tres"))
	],
	8: [
		%"l1-8",
		(preload("res://resources/LevelResources/1-8.tres"))
	],
	9: [
		%"l1-9",
		(preload("res://resources/LevelResources/1-9.tres"))
	],
	10: [
		%"l1-10",
		(preload("res://resources/LevelResources/1-10.tres"))
	],
}

const world_scenes : Array[String] = [
	"res://game_screens/Worlds/world1/world1.tscn",
	
]

func _load_level(level_resource: LevelEnemySpawns) -> void:
	g.level_resource_to_load = level_resource
	SceneManager.change_scene(world_scenes[level_resource.world_index - 1])

func _return_pressed() -> void:
	g.scene_change("res://game_screens/title/title.tscn")

func _weapon_parts_select_button_pressed() -> void:
	g.scene_change("res://game_screens/WeaponPartSelectScreen/weapon_part_select_screen.tscn")

func _ready() -> void:
	return_button.grab_focus()
	
	for n in level_buttons.values(): if n[0] is Button:
		var lvl_res: LevelEnemySpawns = n[1]
		var lvl_btn: Button = n[0]
		lvl_btn.pressed.connect(
			func():_load_level(lvl_res)
			)
		lvl_btn.text = str("Level ", lvl_res.world_index, "-", lvl_res.level_index)
		#lvl_btn.text = str("Level ", lvl_res.level_index)
	
	return_button.pressed.connect(_return_pressed)
	weapon_parts_select_button.pressed.connect(_weapon_parts_select_button_pressed)
