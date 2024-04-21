extends Hitbox

@onready var sprite : Node = $Sprite2D
@onready var parent : Node2D = null
@onready var timer : Node = $Timer

@onready var direction_facing

func _ready():
	self.damage = 20
	timer.one_shot = true
	timer.wait_time = 0.5
	timer.start()
	if direction_facing < 0:
		self.scale = Vector2(-1.25, 1.25)
	else:
		self.scale = Vector2(1.25, 1.25)
	#anim_player.play("attack1")
	await timer.timeout
	self.queue_free()
