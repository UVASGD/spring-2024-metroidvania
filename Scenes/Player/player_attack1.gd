extends Hitbox

@onready var sprite = $Sprite2D
@onready var anim_player : Object = $AnimationPlayer
@onready var parent : Node2D

@onready var direction_facing

func _ready():
	if direction_facing < 0:
		sprite.flip_h = 1
	else:
		sprite.flip_h = 0
	anim_player.play("attack1")
	await anim_player.animation_finished
	self.queue_free()

#func _process(delta):
	#self.global_positon = parent.global_position + Vector2(15 * self.direction_facing, -15)
