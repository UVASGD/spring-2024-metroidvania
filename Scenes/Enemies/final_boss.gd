extends EnemyBase
class_name FinalBoss

@onready var attack_timer : Node = $AttackTimer

func _physics_process(delta):
	anim_player.play("fly")
