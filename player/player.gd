extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var hurtbox = $Hurtbox

@onready var blink_animation_player = $BlinkAnimationPlayer

@onready var stats = PlayerStats
@onready var player_jump = $player_jump
@onready var player_hurt = $player_hurt

@onready var dust_particle_packed : PackedScene = preload("res://items/dust_particle.tscn")

const SPEED = 100.0
const ACCELERATION = 400.0
const FRICTION = 600.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_climb : bool = false
var is_climbing : bool = false
var climbFlipCount : int = 0
var dust_particle_counter : int = 0


func _ready():
	stats.connect("no_health", Callable(self, "queue_free"))
	stats.connect("climbing_state_changed", Callable(self, "changeClimbingState"))


func _physics_process(delta):
	# Add the gravity.
	apply_gravity(delta)

	# Handle Jump.
	handle_jump()
	handle_climbing()
	handle_dust_particle()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_axis = Input.get_axis("ui_left", "ui_right")
	
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	update_animations(input_axis)
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()

func apply_gravity(delta):
	if not is_on_floor() && !is_climbing:
		velocity.y += gravity * delta

func handle_jump():
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("ui_accept"):
			player_jump.play()
			velocity.y = JUMP_VELOCITY
	if not is_on_floor():
		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2

func apply_friction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func handle_acceleration(input_axis, delta):
	if input_axis:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, ACCELERATION * delta)

func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("Run")
	else:
		animated_sprite_2d.play("Idle")
	if not is_on_floor():
		animated_sprite_2d.play("Jump")
	if is_climbing:
		animated_sprite_2d.play("Climb")
		if velocity.y != 0:
			climbFlipCount+=1
			if climbFlipCount > 10:
				animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
				climbFlipCount = 0

func is_player():
	pass
	#print("I am the player")


func _on_hurtbox_area_entered(area):
	#print("the player should now take some damage")
	stats.health -= area.damage
	player_hurt.play()
	hurtbox.start_invincibility(2)

func changeClimbingState():
	if !can_climb:
		print("player has entered the climbing detection zone")
		can_climb = true
	else:
		print("player has exited the climbing detection zone")
		can_climb = false
		is_climbing = false
	print(can_climb)

func handle_climbing():
	if can_climb and !is_climbing:
		if Input.is_action_pressed("ui_up"):
			is_climbing = true
			velocity.x = 0
			return
	if is_climbing:
		if Input.is_action_pressed("ui_up"):
			velocity.y = (JUMP_VELOCITY / 4)
		if Input.is_action_just_released("ui_up"):
			velocity.y = 0
		if Input.is_action_pressed("ui_down"):
			velocity.y = -(JUMP_VELOCITY / 4)
		if Input.is_action_just_released("ui_down"):
			velocity.y = 0


func _on_hurtbox_invincibility_started():
	blink_animation_player.play("Start")


func _on_hurtbox_invincibility_ended():
	blink_animation_player.play("Stop")

func spawn_dust_particle():
	var dust_particle = dust_particle_packed.instantiate()
	dust_particle.global_position = global_position
	get_tree().root.add_child(dust_particle)

func handle_dust_particle():
	if velocity != Vector2.ZERO && is_on_floor():
		dust_particle_counter+=1
	if (dust_particle_counter > 10):
		spawn_dust_particle()
		dust_particle_counter = 0
