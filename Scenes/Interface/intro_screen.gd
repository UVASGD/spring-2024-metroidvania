extends CanvasLayer

@onready var timer : Node = $Timer
@onready var color_rect : Node = $ColorRect
@onready var text_speed : Node = $TextSpeed
@onready var text_box : Object = $TextBox

@onready var world : Node = get_parent()

signal printed

func _ready():
	color_rect.modulate = Color(0.141, 0.141, 0.141)
	text_speed.set_wait_time(.05) # time between letters
	text_box.clear()
	timer.one_shot = true
	timer.wait_time = 1
	timer.start()
	await timer.timeout
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate", Color.BLACK, 1)
	await tween.finished
	slow_print("Directed by Nate Pawlas and Kedrick Fudala")
	await printed
	timer.wait_time = 1
	timer.start()
	await timer.timeout
	text_box.clear()
	var tween2 = create_tween()
	tween2.tween_property(color_rect, "modulate", Color(0.141, 0.141, 0.141, 0), 1)
	await tween2.finished
	end_intro()

func slow_print(text : String):
	for letter in text:
		text_speed.start()
		text_box.add_text(letter)
		await text_speed.timeout
	emit_signal("printed")

func end_intro():
	world.end_intro()
	self.queue_free()
