extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var coyote_time = $CoyoteJumpTimer

@export var speed : float = 1000.0
@export var acceleration : float = 100.0
@export var air_acceleration : float = 500
@export var friction : float = 100.0
@export var jump_velocity : float = -300.0
@export var wall_jump_distance : float = 200
@export var gravity_scale : float = 1.0
@export var air_resistance : float = 200.0

####################################################################################################
########################################## PRIMARY UPDATE ##########################################
####################################################################################################
func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	var input_axis = Input.get_axis("move_left", "move_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	update_anims(input_axis)
	
	var was_on_floor = is_on_floor() #For Coyote Time
	
	move_and_slide() #Physics Update
	
	if  was_on_floor && !is_on_floor() && velocity.y >= 0:
		coyote_time.start()


####################################################################################################
######################################### ATTACK FUNCTIONS #########################################
####################################################################################################
#TODO: Implement a Basic Attack (Maybe in a seperate script?)
#Start with a basic attack first and then we'll think of more abilities depending on ease


####################################################################################################
######################################## MOVEMENT FUNCTIONS ########################################
####################################################################################################
func apply_gravity(delta):
	var scaled_gravity = gravity * self.gravity_scale
	if !is_on_floor():
		velocity.y += scaled_gravity * delta
	if is_on_wall_only():
		velocity.y = 100 if velocity.y > 100 else velocity.y + ((scaled_gravity * 0.25) * delta)
		

func apply_friction(input_axis, delta):
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, self.friction * delta)

func apply_air_resistence(input_axis, delta):
	if input_axis == 0 && !is_on_floor():
		velocity.x = move_toward(velocity.x, 0, self.air_resistance * delta)

func handle_acceleration(input_axis, delta):
	if input_axis && is_on_floor():
		velocity.x = move_toward(velocity.x, self.speed * input_axis, self.acceleration * delta)
		print(self.speed)
	elif input_axis && !is_on_floor():
		handle_air_acceleration(input_axis, delta)

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis:
		velocity.x = move_toward(velocity.x, self.speed * input_axis, self.air_acceleration * delta)

func handle_wall_jump():
	if !is_on_wall(): return
	var wall_normal = get_wall_normal()
	var dist = self.wall_jump_distance
	if Input.is_action_just_pressed("jump") && wall_normal == Vector2.LEFT:
		if Input.is_action_pressed("move_left"): dist * 1.5
		velocity.x =  wall_normal.x * dist
		velocity.y = self.jump_velocity
	if Input.is_action_just_pressed("jump") && wall_normal == Vector2.RIGHT:
		if Input.is_action_pressed("move_right"): dist * 1.5
		velocity.x = wall_normal.x * dist
		velocity.y = self.jump_velocity

func handle_jump():
	if is_on_floor() || coyote_time.time_left > 0.0:
		if Input.is_action_just_pressed("jump"):
			velocity.y = self.jump_velocity
	if !is_on_floor():
		if Input.is_action_just_released("jump") && velocity.y < self.jump_velocity / 2:
			velocity.y = self.jump_velocity / 2
	
	if is_on_wall_only():
		handle_wall_jump()

#TODO: Add further abilities/movement controlls below
# Ideas: Dash, Roll, Maybe a Super Dash, Double Jump



####################################################################################################
######################################## SPRITE/ANIMATIONS #########################################
####################################################################################################
func update_anims(input_axis):
	if input_axis != 0:
		flip_sprite(input_axis)
		anim_player.play("run")
	else:
		anim_player.play("idle")
	
	if !is_on_floor() && velocity.y < 0:
		anim_player.play("jump")
	elif !is_on_floor() && velocity.y == 0:
		anim_player.play("jump_to_fall")
	elif !is_on_floor() && velocity.y > 0:
		anim_player.play("fall")
	
	if is_on_wall_only():
		flip_sprite(-input_axis)
		anim_player.play("wall_slide")

func flip_sprite(input_axis):
	sprite.flip_h = input_axis < 0
	sprite.position.x = input_axis * 2
