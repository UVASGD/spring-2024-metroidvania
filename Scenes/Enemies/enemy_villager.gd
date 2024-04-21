extends EnemyBase
class_name EnemyVillager

@onready var attack_timer : Node = $AttackTimer

@onready var villager_attack : PackedScene = preload("res://Scenes/Enemies/enemy_villager_attack.tscn")

@onready var direction_facing = -1
@onready var in_range : bool = false

func _ready():
	attack_timer.one_shot = true
	attack_timer.wait_time = 1.5

func _physics_process(delta):
	#update_anims(SPEED)
	do_movement(delta)
	if in_range and attack_timer.is_stopped():
		attack()

func do_movement(delta):
	VELOCITY += SPEED * 15
	VELOCITY *= 0.9
	velocity.x = VELOCITY
	velocity += gravity_vector * gravity_magnitude * delta
	move_and_slide()

func attack():
	anim_player.play("attack")
	#spawn_attack()

func spawn_attack():
	var attack_inst = villager_attack.instantiate()
	attack_inst.direction_facing = self.direction_facing
	attack_inst.global_position = self.global_position + Vector2(20 * direction_facing, -10)
	get_parent().add_child(attack_inst)
	attack_timer.start()

func _on_detect_player_area_entered(_area):
	in_range = true

func _on_detect_player_area_exited(_area):
	in_range = false
