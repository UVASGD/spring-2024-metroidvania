extends Hitbox

@onready var sprite : Node = $Sprite2D
@onready var anim_player : Node = $AnimationPlayer
@onready var parent : Node2D = null

@onready var direction_facing

func _ready():
	self.damage = 10
	if direction_facing < 0:
		self.scale = Vector2(-1, 1)
	else:
		self.scale = Vector2(1, 1)
	anim_player.play("attack")
	await anim_player.animation_finished
	self.queue_free()
