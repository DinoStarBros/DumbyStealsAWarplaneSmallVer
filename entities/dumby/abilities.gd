extends CanvasLayer
class_name Abilities

@onready var p : Dumby = get_parent() ## Reference to the Parent Node, Dumby
@export var enable_abilities : bool = true

func _ready() -> void:
	%abilities_row.visible = enable_abilities

func _input(_event: InputEvent) -> void:
	if g.game_state == g.game_states.Combat and enable_abilities:
		if Input.is_action_just_pressed("Ability1"):
			%as1.activate_ability()
		elif Input.is_action_just_pressed("Ability2"):
			%as2.activate_ability()
		elif Input.is_action_just_pressed("Ability3"):
			%as3.activate_ability()
