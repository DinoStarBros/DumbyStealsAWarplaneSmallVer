extends Node2D
class_name HealthComponent

@export var hp_bar : ProgressBar
@export var hp_text : Label
@export var ouchnim : AnimationPlayer ## Needs to have the animations "Ouch" and "Die"
#@export var cooler_hp_bar : TextureProgressBar

@export var max_hp : = 10.0
var hp : float

func _ready() -> void:
	hp = max_hp

func damage(attack:Attack) -> void:
	
	hp -= attack.attack_damage
	g.spawn_txt(str(roundi(attack.attack_damage)), global_position)
	
	if hp > 0:
		
		if ouchnim:
			ouchnim.play("Ouch")
		
		get_parent().damage(attack)
		
	else:
		
		if ouchnim:
			if get_parent() is Dumby:
				ouchnim.play("Die")
			else:
				_spawn_death_fx_explosion()
				get_parent().queue_free()
		
		get_parent().Dead(attack)

func _process(_delta:float)->void:
	
	if hp_bar:
		hp_bar.max_value = max_hp
		hp_bar.value = hp
	
	if hp_text:
		hp_text.text = str(roundi(hp), "/", roundi(max_hp))

var death_fx_explosion_scn : PackedScene = preload("res://juices/death_fx_explosion.tscn")
func _spawn_death_fx_explosion() -> void:
	var death_fx_explosion : Node2D = death_fx_explosion_scn.instantiate()
	death_fx_explosion.global_position = global_position
	g.world.add_child(death_fx_explosion)
	death_fx_explosion.global_position = global_position
