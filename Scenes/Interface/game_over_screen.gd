extends CanvasLayer

@onready var color_rect : Node = $ColorRect
@onready var label : Node = $Label

func _ready():
	color_rect.modulate = Color(1, 1, 1, 0)
	label.modulate = Color(0.91, 0, 0.09, 0)
	label.scale = Vector2(0.5, 0.5)
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate", Color(1, 1, 1), 6)
	var tween2 = create_tween()
	tween2.tween_property(label, "modulate", Color(0.91, 0, 0.09), 6)
	var tween3 = create_tween()
	tween3.tween_property(label, "scale", Vector2(1, 1), 6)
	await tween3.finished
	get_tree().paused = true
