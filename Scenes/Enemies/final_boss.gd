extends EnemyBase
class_name FinalBoss

@onready var attack_timer : Node = $AttackTimer

func _ready():
	set_health(200)

func _physics_process(_delta):
	anim_player.play("fly")
