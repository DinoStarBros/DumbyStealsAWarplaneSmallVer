extends CharacterBody2D
class_name Dumby

var half_viewport : Vector2
var dir_to_mouse : Vector2
var dist_to_mouse : float
var accelerate_time : float = 0
var attack : Attack = Attack.new()
var position_sensitive_rect : Rect2
var aim_position : Vector2
var dir_plane : Vector2
var damage_iframes : float = 0
var roll_iframes : float = 0
var shooting : bool = false

@onready var health_component: HealthComponent = %HealthComponent
@onready var velocity_component: VelocityComponent = %VelocityComponent
@onready var rotation_component: RotationComponent = %RotationComponent
@onready var weapons_parent: WeaponsParent = %weapons_parent
@onready var floorhurtbox: CollisionShape2D = %floorhurtbox
@onready var hurtbox: CollisionShape2D = %hurtbox

func _ready() -> void:
	
	g.player = self
	%weapons_parent.process_mode = Node.PROCESS_MODE_INHERIT
	
	PlayerStats.money = PlayerStats.BASE_MONEY
	
	PlayerStats.speed = PlayerStats.BASE_SPD
	PlayerStats.rotation_speed = PlayerStats.BASE_ROT_SPD
	PlayerStats.acceleration = PlayerStats.BASE_ACCEL
	PlayerStats.max_iframes = PlayerStats.BASE_MAX_IFRAMES

func _physics_process(delta: float) -> void:
	
	# Handling functions
	roll_handling(delta)
	_left_joystick_handle()
	
	if g.game_state != g.game_states.Cutscene:
		move_and_slide()
	
	half_viewport = get_viewport_rect().size / 2.0
	 
	# Mouse stuff
	dir_to_mouse = global_position.direction_to(get_global_mouse_position())
	dist_to_mouse = global_position.distance_to(get_global_mouse_position())
	
	# Handling the Velocity and Rotation Component stuff
	dir_plane = rotation_component.direction
	if g.game_state != g.game_states.Cutscene:
		velocity_component.other_velocity_handle(delta, dir_plane, accelerating)
	
	if controller:
		rotation_component.plane_rotation_handling(
		delta,
		global_position + controller_joypad_vector
		)
	else:
		rotation_component.plane_rotation_handling(
		delta,
		get_global_mouse_position()
		)
	
	if accelerating:
		if not %jet.playing:
			%jet.play()
	else:
		%jet.stop()
	
	if g.mobile:
		pass
	else:
		if SaveLoad.SaveFileData.switch_accelerate_roll:
			accelerating = Input.is_action_pressed("roll") and g.game_state == g.game_states.Combat
		else:
			accelerating = Input.is_action_pressed("accelerate") and g.game_state == g.game_states.Combat
	
	if accelerating:
		accelerate_time = min(5, accelerate_time + delta)
	else:
		accelerate_time = 0
	
	player_stats_handling()
	iframes_handling(delta)
	
	shooting = (Input.is_action_pressed("shoot") and 
	g.game_state == g.game_states.Combat
	)
	
	if not controller:
		%Crosshair2.position = rotation_component.direction * dist_to_mouse
		%Crosshair.global_position = get_global_mouse_position()
		%Crosshair.global_position = get_global_mouse_position()

func _unhandled_input(event: InputEvent) -> void: ## For camera aiming, dynamic camera follow mouse
	if controller:
		aim_position = dir_plane * half_viewport * left_joystick_length
	
	else:
		if event is InputEventMouseMotion:
			aim_position = (event.position - half_viewport)

var accelerating : bool = false

@warning_ignore("shadowed_variable")
func damage(attack:Attack)->void:
	Hurt.emit(attack)
	damage_iframes += PlayerStats.max_iframes

func Dead(_attack:Attack)->void:
	#g.cam.screen_shake(40, 1)
	g.game_state = g.game_states.Lost
	set_physics_process(false)
	%explod.play(.4)
	weapons_parent.process_mode = Node.PROCESS_MODE_DISABLED
	
	%menu.grab_focus()
	
	accelerating = false
	%jet.stop()
	%speed_lines_parent.hide()

@onready var plane_sprite: AnimatedSprite2D = %PlaneSprite

var controller : bool = false ## Set to true if using controller, false if Mouse

func finish_collect() -> void:
	%collect2.pitch_scale = randf_range(1.1, 1.3)
	%collect2.play()

var rolling : bool = false ## If the player is rolling or not
var roll_duration : float = 0.5 ## The amount of time the roll will last
var roll_cooldown : float = 0.3 ## The amount of time you have to wait after a roll before being able to perform another
var roll_time : float = 0 ## The amount of time that has passed since the start of the roll
var roll_cd_time : float = 0
func roll_handling(delta: float) -> void:
	if roll_cd_time <= 0 and not rolling:
		if SaveLoad.SaveFileData.switch_accelerate_roll:
			if Input.is_action_just_pressed("accelerate"):
				_roll()
				
		else:
			if Input.is_action_just_pressed("roll"):
				_roll()
	
	if rolling:
		roll_time += delta
	
	if roll_time >= roll_duration:
		rolling = false
		roll_time = 0
		roll_cd_time = roll_cooldown
	
	if roll_cd_time > 0:
		roll_cd_time -= delta

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion or event is InputEventJoypadButton:
		controller = true
	elif event is InputEventMouse:
		controller = false

func _roll() -> void:
	Roll.emit()
	
	%roll.pitch_scale = randf_range(0.8,1.2)
	%roll.play()
	
	%rollnim.play("roll")
	
	roll_iframes += roll_duration - 0.1
	
	roll_time = 0
	rolling = true
	
	plane_sprite.frame = 0

var controller_joypad_vector : Vector2 ## Vector of the left analog stick
var left_joystick_vector : Vector2
var left_joystick_length : float = 0
func _left_joystick_handle() -> void:
	left_joystick_vector = Input.get_vector(
		"left_stick", "right_stick", "up_stick", "down_stick"
		)
	if left_joystick_vector != Vector2.ZERO:
		#controller_joypad_vector = controller_joypad_vector.lerp(left_joystick_vector, 1.0 - exp(-10 * get_physics_process_delta_time()))
		controller_joypad_vector = left_joystick_vector
	left_joystick_length = controller_joypad_vector.length()

### Signals for player actions ###
signal Shoot
signal Roll
signal Hurt

func _init() -> void:
	Shoot.connect(_on_shoot)
	Roll.connect(_on_roll)
	Hurt.connect(_on_hurt)

func _on_shoot() -> void:
	pass

func _on_roll() -> void:
	pass

func _on_perfect_roll() -> void:
	pass

func _on_hurt(_attack: Attack) -> void:
	pass

func player_stats_handling() -> void:
	velocity_component.max_speed = PlayerStats.speed
	rotation_component.turn_speed = PlayerStats.rotation_speed
	velocity_component.acceleration = PlayerStats.acceleration

func iframes_handling(delta: float) -> void:
	damage_iframes = max(damage_iframes - delta, 0)
	roll_iframes = max(roll_iframes - delta, 0)
	
	var enable_invincibility : bool = (damage_iframes > 0 or roll_iframes > 0) or (g.player_invincible)
	
	if g.game_state == g.game_states.Combat:
		hurtbox.disabled = enable_invincibility and health_component.hp > 0
		floorhurtbox.disabled = enable_invincibility and health_component.hp > 0
	else:
		hurtbox.disabled = true
		floorhurtbox.disabled = true
