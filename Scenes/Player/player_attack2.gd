extends Hitbox

@onready var sprite : Object = $Sprite2D
@onready var parent : Node2D = null

@onready var direction_facing

func _ready():
	if direction_facing < 0:
		sprite.flip_h = 1
	else:
		sprite.flip_h = 0
	#self.queue_free()

func _process(_delta):
	global_position.x += 8 * direction_facing
