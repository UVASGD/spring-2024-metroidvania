extends Sprite2D
class_name NPCBase

@onready var interact_icon : Object = $InteractIcon
@onready var interactable_area : Object = $InteractableArea
@onready var text_box : Object = $TextBox
@onready var text_speed : Object = $TextSpeed
@onready var text_timeout : Object = $TextTimeout

@onready var is_speaking : bool = false
@export var dialogue : String = "This is a test string!"

func _ready():
	interact_icon.visible = false
	text_speed.set_wait_time(.05) # time between letters
	text_timeout.set_wait_time(4)
	text_box.clear()
	text_box.z_index = 1

func _process(delta):
	pass

func interact():
	if !is_speaking:
		text_box.clear()
		speak_text(dialogue)

func speak_text(text : String):
	is_speaking = true
	for letter in text:
		text_speed.start()
		text_box.add_text(letter)
		await text_speed.timeout
	is_speaking = false
	text_timeout.start()
	await text_timeout.timeout
	text_box.clear()
