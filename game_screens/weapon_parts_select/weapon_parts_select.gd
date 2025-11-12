extends Control
class_name WeaponPartsSelect

@onready var weapon_select_arrow: Label = %weapon_select_arrow ## A way to visually represent what starting weapon you selected

var current_weapon_button_selected_res : WeaponButton
var weapon_sel_arr_desired_pos : Vector2
var allow_proceed : bool = false

func _ready() -> void:
	%return.grab_focus()
	
	# Level button signal connections
	%return.pressed.connect(_return_pressed)
	%next.pressed.connect(_next_pressed)
	
	g.current_weapon_button_selected_res = null

func _return_pressed() -> void:
	g.scene_change("res://game_screens/title/title.tscn")

func _next_pressed() -> void:
	if g.current_weapon_button_selected_res:
		allow_proceed = true
	else:
		allow_proceed = false
	
	if allow_proceed:
		g.scene_change("res://game_screens/level_select/level_select.tscn")
	else:
		%errorTxt.text = str("Pick a weapon before proceeding!")
		%errorsProceed.play("error")

func _process(delta: float) -> void:
	if current_weapon_button_selected_res:
		g.current_weapon_button_selected_res = current_weapon_button_selected_res.weapon_item_res
		
		weapon_sel_arr_desired_pos = (
			current_weapon_button_selected_res.global_position + 
			Vector2(-25, -5)
			)
		
	else:
		g.current_weapon_button_selected_res = null
		
		weapon_sel_arr_desired_pos = Vector2(-2000, 360)
	
	weapon_select_arrow.global_position = weapon_select_arrow.global_position.lerp(weapon_sel_arr_desired_pos, 12 * delta)
