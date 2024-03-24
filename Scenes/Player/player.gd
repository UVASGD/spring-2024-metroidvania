extends CharacterBody2D
class_name Player

@onready var attack1 : PackedScene = preload("res://Scenes/Player/player_attack1.tscn")

const gravity_vector : Vector2 = Vector2(0, 1)
const gravity_magnitude : int = 800

@onready var anim_player : Object = $AnimationPlayer
@onready var sprite : Object = $Sprite2D
@onready var coyote_timer : Object = $CoyoteJumpTimer
@onready var dash_timer : Object = $DashTimer
@onready var attack_timer : Object = $AttackTimer
@onready var interaction_area : Object = $InteractArea

@onready var max_health : int = 100
@onready var current_health : int = max_health
@onready var attack1_damage : int = 20
@onready var attack1_speed : float = 0.75

@export var SPEED : float = 2000.0
@export var VELOCITY : float = 0.0

@export var direction_facing = 1
@onready var is_dashing : bool = false
@onready var is_attacking : bool = false

@onready var interactable_area_count : int = 0
@onready var is_interacting : bool = false
@onready var can_interact : bool = false

func _ready():
	pass

########################################## PRIMARY UPDATE ##########################################
func _physics_process(delta):
	get_inputs()
	update_anims(SPEED)
	do_movement(delta)

func get_inputs():
	if !is_interacting:
		SPEED = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		if !is_dashing:
			if is_on_floor() && Input.is_action_just_pressed("jump"):
				jump()
			if Input.is_action_just_pressed("dash"):
				pass
			if Input.is_action_just_pressed("attack1"):
				spawn_attack1()
			if is_on_wall_only() and Input.is_action_just_pressed("jump"):
				wall_jump()
			if Input.is_action_just_pressed("interact") && interactable_area_count > 0:
				interact()

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
func spawn_attack1():
	if(attack_timer.is_stopped()):
		var attack1_inst = attack1.instantiate()
		attack1_inst.global_position = self.global_position + Vector2(25 * self.direction_facing, -15)
		attack1_inst.direction_facing = self.direction_facing
		#attack_inst.parent = self
		attack1_inst.damage = attack1_damage
		get_parent().add_child(attack1_inst)
		attack_timer.wait_time = attack1_speed
		attack_timer.start()

####################################### INTERACTION FUNCTIONS ######################################
func interact():
	var closest_area = null
	var closest_distance = 100
	for area in get_tree().get_nodes_in_group("InteractableAreas"):
		if(area.global_position.distance_to(global_position) < closest_distance):
			closest_distance = area.global_position.distance_to(global_position)
			closest_area = area
	if(closest_area != null):
		var parent = closest_area.get_parent()
		parent.interact()
	print("I am now interacting!")

func _on_interact_area_area_entered(area):
	if(area.name == "InteractableArea"):
		area.add_to_group("InteractableAreas")
		area.get_parent().interact_icon.visible = true
		interactable_area_count += 1

func _on_interact_area_area_exited(area):
	if(area.name == "InteractableArea"):
		area.remove_from_group("InteractableAreas")
		area.get_parent().interact_icon.visible = false
		interactable_area_count -= 1

######################################## SPRITE/ANIMATIONS #########################################
func update_anims(input_axis):
	if input_axis != 0:
		flip_sprite(input_axis)
		anim_player.play("run")
	else:
		anim_player.play("idle")
	
	if !is_on_floor() && velocity.y < 0:
		anim_player.play("jump")
	#elif !is_on_floor() && velocity.y == 0:
		#anim_player.play("jump_to_fall")
	elif !is_on_floor() && velocity.y > 0:
		anim_player.play("fall")
	
	#if is_on_wall_only():
		#flip_sprite(-input_axis)
		#anim_player.play("wall_slide")

func flip_sprite(input_axis):
	sprite.flip_h = input_axis < 0
	sprite.position.x = input_axis * 2
	if input_axis < 0:
		direction_facing = -1
	elif input_axis > 0:
		direction_facing = 1
