extends Ability

@export var rocket_amount : int = 10
const delay : float = 0.075
var dir_to_mouse: Vector2
var p : Dumby

var trig_vector : Vector2
var trig_deg : float

var amount : int = 0
func _ready() -> void:
	%rocketDelaytimer.timeout.connect(_on_rocketdelay_timeout)

func activate_ability() -> void:
	usable = false
	
	p = g.player
	cooldown_time = cooldown
	
	%rocketDelaytimer.start(delay)

const rocket_scn : PackedScene = preload(References.projectile_scns["homing_rocket"])
func spawn_rocket() -> void:
	if p.health_component.hp >= 1:
	
		var rocket : Homing_Rocket = rocket_scn.instantiate()
		
		setting_rocket_parameters(rocket)
		g.game.add_child(rocket)
		setting_rocket_parameters(rocket)
		
		%shoot1.pitch_scale = randf_range(0.9, 1.1)
		%shoot1.play()
		
		%shoot2.pitch_scale = randf_range(0.7, 1.1)
		%shoot2.play(0.2)

func setting_rocket_parameters(rocket: Homing_Rocket) -> void:
	rocket.lifetime = 10
	rocket.dmg = 6
	rocket.explosion_dmg = 4
	rocket.initial_velocity = trig_vector
	rocket.global_position = g.player.global_position

var current_rocket_amnt : int
func _on_rocketdelay_timeout() -> void:
	
	trig_deg = (360/float(rocket_amount)) * current_rocket_amnt
	trig_vector.x = cos(deg_to_rad(trig_deg))
	trig_vector.y = sin(deg_to_rad(trig_deg))
	
	spawn_rocket()
	current_rocket_amnt += 1
	if current_rocket_amnt >= rocket_amount:
		%rocketDelaytimer.stop()
		current_rocket_amnt = 0
