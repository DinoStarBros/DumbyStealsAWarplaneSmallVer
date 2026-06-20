extends Area2D
class_name Evade

signal Perfect_Roll

@onready var shing_sfx: AudioStreamPlayer = %shing

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		g.frame_freeze(0.5,0.2)
		Perfect_Roll.emit()
		perfect_roll_fx()

func perfect_roll_fx() -> void:
	rotation = randf_range(0, PI)
	shing_sfx.pitch_scale = 1 + randf_range(-.2, .2)
	shing_sfx.play()
	%prfxAnim.play("prfxAnimation")
	g.spawn_txt("Barrel Roll!", global_position)
