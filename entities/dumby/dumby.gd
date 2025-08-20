extends CharacterBody2D
class_name Dumby

var half_viewport : Vector2
var dir_to_mouse : Vector2
var dist_to_mouse : float
var accelerate_time : float = 0

@onready var health_component: HealthComponent = %HealthComponent
#@onready var hurtbox_component: HurtboxComponent = %HurtboxComponent
@onready var velocity_component: VelocityComponent = %VelocityComponent
@onready var rotation_component: RotationComponent = %RotationComponent

func _ready() -> void:
	
	g.player = self
	%weapons_parent.process_mode = Node.PROCESS_MODE_INHERIT

var attack : Attack = Attack.new()

var position_sensitive_rect : Rect2
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Ability2"):
		AudioManager.create_2d_audio(
			get_global_mouse_position(),
			AudioSettings.types.EXPLODE1
	)
	
	roll_handling(delta)
	
	move_and_slide()
	
	half_viewport = get_viewport_rect().size / 2.0
	 
	# Mouse stuff
	dir_to_mouse = global_position.direction_to(get_global_mouse_position())
	dist_to_mouse = global_position.distance_to(get_global_mouse_position())
	
	# Handling the Velocity and Rotation Component stuff
	dir_plane = rotation_component.direction
	
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
	
	left_joystick_handle()
	
	if accelerating:
		if not %jet.playing:
			%jet.play()
	else:
		%jet.stop()
	
	if g.mobile:
		pass
	else:
		if g.switch_acc_roll:
			accelerating = Input.is_action_pressed("roll")
		else:
			accelerating = Input.is_action_pressed("accelerate")
	
	if accelerating:
		
		accelerate_time += delta
		if accelerate_time > 5:
			accelerate_time = 5
	else:
		accelerate_time = 0

var aim_position : Vector2
var dir_plane : Vector2
func _unhandled_input(event: InputEvent) -> void: ## For camera aiming, dynamic camera follow mouse
	if controller:
		aim_position = dir_plane * half_viewport * left_joystick_length
	
		%Crosshair.position = aim_position
	else:
		if event is InputEventMouseMotion:
			aim_position = (event.position - half_viewport)
			
			%Crosshair.global_position = get_global_mouse_position()

var accelerating : bool = false

func damage(_attack:Attack)->void:
	#g.cam.screen_shake(20, 0.3)
	pass

func Dead(_attack:Attack)->void:
	#g.cam.screen_shake(40, 1)
	g.game_state = g.game_states.Lost
	set_physics_process(false)
	%explod.play(.4)
	%death.play("die")
	%weapons_parent.process_mode = Node.PROCESS_MODE_DISABLED
	%Abilities.process_mode = Node.PROCESS_MODE_DISABLED

@onready var plane_sprite: AnimatedSprite2D = %PlaneSprite
@onready var dir_to_m: Node2D = %dir_to_turn

@export var controller : bool = false ## Set to true if using controller, false if Mouse

#@export var turn_speed : float = 7 ## How fast the plane can turn to face the mouse / aim
@export var thing_to_rotate : Node2D
var plane_sprite_rotation_degrees : float ## Used for determining the frame for the ship sprite
var direction : Vector2 = Vector2.ZERO ## The vector of the rotation of the rotated node
var rot_deg_change : float

func _on_exp_pickup_area_entered(area: Area2D) -> void:
	if area is XpOrb:
		area.collected = true
		%collect.pitch_scale = randf_range(0.9, 1.2)
		%collect.play()

func finish_collect() -> void:
	%collect2.pitch_scale = randf_range(1.1, 1.3)
	%collect2.play()

var rolling : bool = false ## If the player is rolling or not
var roll_duration : float = 0.5 ## The amount of time the roll will last
var roll_cooldown : float = 0.1 ## The amount of time you have to wait after a roll before being able to perform another
var roll_time : float = 0 ## The amount of time that has passed since the start of the roll
var roll_cd_time : float = 0
func roll_handling(delta: float) -> void:
	if roll_cd_time <= 0 and not rolling:
		if g.switch_acc_roll:
			if Input.is_action_just_pressed("accelerate"):
				roll()
		else:
			if Input.is_action_just_pressed("roll"):
				roll()
	
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

func roll() -> void:
	%roll.pitch_scale = randf_range(0.8,1.2)
	%roll.play()
	
	%rollnim.play("roll")
		
	roll_time = 0
	rolling = true
		
	plane_sprite.frame = 0

var controller_joypad_vector : Vector2 ## Vector of the left analog stick
var left_joystick_vector : Vector2
var left_joystick_length : float = 0
func left_joystick_handle() -> void:
	left_joystick_vector = Input.get_vector(
		"left_stick", "right_stick", "up_stick", "down_stick"
		)
	
	if left_joystick_vector != Vector2.ZERO:
		#controller_joypad_vector = controller_joypad_vector.lerp(left_joystick_vector, 1.0 - exp(-10 * get_physics_process_delta_time()))
		controller_joypad_vector = left_joystick_vector
	
	left_joystick_length = controller_joypad_vector.length()
