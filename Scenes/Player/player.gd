extends CharacterBody2D
class_name Player

@onready var attack1 : PackedScene = preload("res://Scenes/player_attack1.tscn")

@onready var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@onready var gravity_magnitude : int =800

@onready var anim_player : Object = $AnimationPlayer
@onready var sprite : Object = $Sprite2D
@onready var coyote_time : Object = $CoyoteJumpTimer

@onready var max_health : int = 100
@onready var current_health : int = max_health

@export var SPEED : float = 2000.0
@export var VELOCITY : float = 0.0

@export var direction_facing = 1

########################################## PRIMARY UPDATE ##########################################
func _physics_process(delta):
	get_inputs()
	update_anims(SPEED)
	do_movement(delta)

func get_inputs():
	SPEED = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if(is_on_floor() and Input.is_action_just_pressed("jump")):
		jump()
	
	if is_on_wall_only() and Input.is_action_just_pressed("jump"):
		wall_jump()

	if(Input.is_action_just_pressed("attack1")):
		spawn_hitbox()

######################################## MOVEMENT FUNCTIONS ########################################
func do_movement(delta):
	VELOCITY += SPEED * 30
	VELOCITY *= 0.825
	velocity.x = VELOCITY
	velocity += gravity_vector * gravity_magnitude * delta
	move_and_slide()

func jump():
	velocity.y = -275

func wall_jump():
	var wall_normal = get_wall_normal()
	var dist = 250
	VELOCITY =  wall_normal.x * dist
	velocity.y = -300

######################################### COMBAT FUNCTIONS #########################################
func spawn_hitbox():
	var proj_inst = attack1.instantiate()
	proj_inst.global_position = global_position + Vector2(15 * direction_facing, -15)
	proj_inst.damage = 5
	proj_inst.scale = Vector2(0.1,0.1)
	get_parent().add_child(proj_inst)


######################################## SPRITE/ANIMATIONS #########################################
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
	if input_axis < 0:
		direction_facing = -1
	elif input_axis > 0:
		direction_facing = 1
