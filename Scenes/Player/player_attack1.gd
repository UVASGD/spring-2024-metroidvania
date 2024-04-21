extends Hitbox

@onready var sprite : Node = $Sprite2D
@onready var anim_player : Node = $AnimationPlayer
@onready var parent : Node2D = null

@onready var direction_facing

func _ready():
	self.damage = 10
	if direction_facing < 0:
		self.scale = Vector2(-2, 2)
	else:
		self.scale = Vector2(2, 2)
	anim_player.play("attack1")
	await anim_player.animation_finished
	self.queue_free()

func _process(_delta):
	if parent != null:
		self.global_position = parent.global_position + Vector2(10 * self.direction_facing, -15)
