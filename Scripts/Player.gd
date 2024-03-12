extends CharacterBody2D

@onready var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@onready var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var coyote_time = $CoyoteJumpTimer

@export var SPEED : float = 1000.0
@export var VELOCITY : float = 0.0

func _physics_process(delta):
	get_inputs()
	update_anims(SPEED)
	do_movement(delta)

func get_inputs():
	SPEED = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if(is_on_floor() and Input.is_action_just_pressed("jump")):
		velocity.y = -250

func do_movement(delta):
	VELOCITY += SPEED * 15
	VELOCITY *= 0.9
	velocity.x = VELOCITY
	velocity += gravity_vector * gravity_magnitude * delta
	move_and_slide()

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
