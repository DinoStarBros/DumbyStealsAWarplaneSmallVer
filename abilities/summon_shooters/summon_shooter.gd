extends Ability

@export var amount : int = 10
var p : Dumby

func activate_ability() -> void:
	usable = false
	
	p = g.player
	cooldown_time = cooldown
	
	%shoot1.pitch_scale = randf_range(0.9, 1.1)
	%shoot1.play()
	
	%shoot2.pitch_scale = randf_range(0.7, 1.1)
	%shoot2.play(0.2)
	
	for n in amount:
		spawn_shooter(n)

const shooter_scn : PackedScene = preload(References.summon_scns["shooter_summon"])
func spawn_shooter(ndex : int) -> void:
	var shooter : ShooterSummon = shooter_scn.instantiate()
	
	shooter.summon_index = ndex
	shooter.max_summon_amount = amount
	
	g.game.add_child(shooter)
	
	shooter.global_position = g.player.global_position
	
