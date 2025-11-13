extends Node2D
class_name HealthComponent

@export var hp_bar : ProgressBar
@export var hp_text : Label
@export var ouchnim : AnimationPlayer
#@export var cooler_hp_bar : TextureProgressBar

@export var max_hp : = 10.0
var hp : float

func _ready() -> void:
	hp = max_hp

func damage(attack:Attack) -> void:
	
	g.spawn_txt(str(roundi(attack.attack_damage)), global_position)
	get_parent().damage(attack)
	
	hp -= attack.attack_damage
	
	if ouchnim:
		ouchnim.play("Ouch")

func _process(_delta:float)->void:

	if hp_bar:
		hp_bar.max_value = max_hp
		hp_bar.value = hp
	
	if hp_text:
		hp_text.text = str(roundi(hp), "/", roundi(max_hp))
