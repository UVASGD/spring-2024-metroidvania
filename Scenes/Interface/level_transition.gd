extends CanvasLayer

@onready var color_rect : Node = $ColorRect
@onready var timer : Node = $Timer
@onready var world : Node = get_parent()

func _ready():
	color_rect.modulate = Color(0, 0, 0, 0)
	timer.one_shot = true
	timer.wait_time = 0.5
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate", Color(0, 0, 0), 0.5)
	await tween.finished
	world.next_level()
	timer.start()
	await timer.timeout
	var tween2 = create_tween()
	tween2.tween_property(color_rect, "modulate", Color(0, 0, 0, 0), 0.5)
	await tween2.finished
	world.allow_player_control()
