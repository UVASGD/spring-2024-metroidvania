extends Hitbox

@onready var sprite : Node = $Sprite2D
@onready var anim_player : Node = $AnimationPlayer
@onready var parent : Node2D = null

@onready var direction_facing

func _ready():
	self.damage = 10
	if direction_facing < 0:
		sprite.flip_h = 1
	else:
		sprite.flip_h = 0
	anim_player.play("attack1")
	await anim_player.animation_finished
	self.queue_free()

func _process(_delta):
	if parent != null:
		self.global_position = parent.global_position + Vector2(15 * self.direction_facing, -15)
