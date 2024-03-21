extends CharacterBody2D
class_name Player

@onready var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@onready var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_player : Object = $AnimationPlayer
@onready var sprite : Object = $Sprite2D
@onready var coyote_time : Object = $CoyoteJumpTimer
@onready var interaction_area : Object = $InteractArea

@onready var max_health : int = 100
@onready var current_health : int = max_health

@export var SPEED : float = 1000.0
@export var VELOCITY : float = 0.0

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
				print("I attack!")

			if Input.is_action_just_pressed("interact") && interactable_area_count > 0:
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

######################################## MOVEMENT FUNCTIONS ########################################
func do_movement(delta):
	VELOCITY += SPEED * 15
	VELOCITY *= 0.9
	velocity.x = VELOCITY
	velocity += gravity_vector * gravity_magnitude * delta
	move_and_slide()

func jump():
	velocity.y = -250

######################################### COMBAT FUNCTIONS #########################################





####################################### INTERACTION FUNCTIONS ######################################
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



