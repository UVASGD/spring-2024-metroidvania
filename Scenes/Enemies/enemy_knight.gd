extends EnemyBase
class_name EnemyKnight

@onready var attack_timer : Node = $AttackTimer
@onready var turn_timer : Node = $TurnTimer
@onready var raycast : Node = $Sprite2D/RayCast2D

@onready var knight_attack : PackedScene = preload("res://Scenes/Enemies/knight_attack1.tscn")

@onready var direction_facing = -1
@onready var in_range : bool = false
@onready var attacking : bool = false

func _ready():
	set_health(100)
	attack_timer.one_shot = true
	attack_timer.wait_time = 1.5
	turn_timer.wait_time = 1
	turn_timer.one_shot = true

func _physics_process(delta):
	update_anims()
	do_movement(delta)
	if in_range:
		SPEED = 0
		if attack_timer.is_stopped():
			attack()
		if !attacking:
			anim_player.play("idle")
	else:
		SPEED = 3 * direction_facing
	var collider = raycast.get_collider()
	if collider is TileMap and turn_timer.is_stopped():
		direction_facing *= -1
		turn_timer.start()

func do_movement(delta):
	VELOCITY += SPEED
	VELOCITY *= 0.9
	velocity.x = VELOCITY
	velocity += gravity_vector * gravity_magnitude * delta
	move_and_slide()

func attack():
	attacking = true
	anim_player.play("attack")
	await anim_player.animation_finished
	attacking = false

func spawn_attack():
	var attack_inst = knight_attack.instantiate()
	attack_inst.direction_facing = self.direction_facing
	attack_inst.global_position = self.global_position + Vector2(20 * direction_facing, 10)
	get_parent().add_child(attack_inst)
	attack_timer.start()

func update_anims():
	if abs(SPEED) > 0:
		anim_player.play("walk")
		
	if direction_facing == 1:
		sprite.scale = Vector2(-1, 1)
	else:
		sprite.scale = Vector2(1, 1)

func _on_detect_player_area_entered(_area):
	in_range = true

func _on_detect_player_area_exited(_area):
	in_range = false
