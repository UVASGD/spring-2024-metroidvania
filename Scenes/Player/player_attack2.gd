extends Hitbox

@onready var sprite : Node = $Sprite2D
@onready var parent : Node = null

@onready var direction_facing

func _ready():
	if direction_facing < 0:
		sprite.flip_h = 1
	else:
		sprite.flip_h = 0

func _process(_delta):
	global_position.x += 4 * direction_facing
	if parent:
		if self.global_position.distance_to(parent.global_position) > 150:
			queue_free()
