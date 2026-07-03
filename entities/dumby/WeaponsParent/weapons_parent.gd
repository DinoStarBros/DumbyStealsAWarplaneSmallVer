extends Node2D
class_name WeaponsParent

@export var dumby : Dumby
@export var weapons_hotbar: Control

@onready var rotation_component: RotationComponent = %RotationComponent
@onready var switch_sfx: AudioStreamPlayer = %switch
@onready var evade_box: EvadeBox = %evade_box
@onready var curr_weapon_txt: Label = %curr_weap

var current_weapon : Weapon
var current_weapon_idx : int
var buff_time : float = 0
var texrec_pos_offset : float = 0

const WEAPON_SCN : PackedScene = preload("res://scenes/weapon/weapon.tscn")

func _ready() -> void:
	g.weapons_parent = self
	
	evade_box.Perfect_Roll.connect(
		func():
		buff_time = 5
	)
	
	for weapon in SaveLoad.SaveFileData.equipped_weapons:
		add_weapon(weapon)
	current_weapon_idx = 0
	switch_weapon(0)

func add_weapon(weapon_res: WeaponStats) -> void:
	var weapon_node : Weapon = WEAPON_SCN.instantiate()
	weapon_node.weapon_stat_res = weapon_res
	weapon_node.plr_rotation_component = rotation_component
	add_child(weapon_node)
	current_weapon = weapon_node
	current_weapon_idx = get_child_count() - 1
	switch_weapon(0)
	weapon_visuals()

func _physics_process(delta: float) -> void:
	buff_time = max(0, buff_time - delta)
	
	if Input.is_action_just_pressed("next_weapon"):
		switch_weapon(1)
	elif Input.is_action_just_pressed("prev_weapon"):
		switch_weapon(-1)

func switch_weapon(change: int) -> void:
	switch_sfx.pitch_scale = 1.5 + randf_range(-.2,.2)
	switch_sfx.play(0.17)
	
	current_weapon_idx += change
	current_weapon_idx = wrapi(current_weapon_idx, 0, get_child_count())
	current_weapon = get_child(current_weapon_idx)
	weapon_visuals()

func weapon_visuals() -> void:
	curr_weapon_txt.text = TranslationServer.tr(current_weapon.weapon_stat_res.key + "Name")
	
	for texturerect in weapons_hotbar.get_children():
		texturerect.queue_free()
	
	var ndex : int = -1
	texrec_pos_offset = 0
	for child in get_children():if child is Weapon:
		ndex += 1
		make_texture_rect(child.weapon_stat_res, ndex)

func make_texture_rect(weapon_resource: WeaponStats, index: int) -> void:
	var texture_rect : TextureRect = TextureRect.new()
	
	texture_rect.texture = weapon_resource.texture
	texture_rect.name = weapon_resource.key
	texture_rect.scale.x = 2
	
	texture_rect.position.x += 32 * index
	texture_rect.position.x += texrec_pos_offset
	
	weapons_hotbar.add_child(texture_rect)
	
	if index == current_weapon_idx:
		texture_rect.scale.x = 2.5
		texture_rect.position.y = -8
		texrec_pos_offset = 8
	
	texture_rect.scale.y = texture_rect.scale.x
