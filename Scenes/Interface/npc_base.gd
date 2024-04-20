extends Node2D
class_name NPCBase

@onready var world : Node = get_parent().get_parent()

@onready var sprite : Node = $Sprite2D
@onready var interact_icon : Node = $InteractIcon
@onready var interactable_area : Node = $InteractableArea
@onready var text_box : Node = $TextBox
@onready var text_speed : Node = $TextSpeed
@onready var text_timeout : Node = $TextTimeout

@onready var is_speaking : bool = false
@export var dialogue : Array

func _ready():
	interact_icon.visible = false
	text_speed.set_wait_time(.05) # time between letters
	text_timeout.one_shot = true
	text_box.clear()
	text_box.z_index = 1

func interact():
	if !is_speaking:
		text_box.clear()
		speak_text(dialogue)

func speak_text(text : Array):
	is_speaking = true
	for line in text:
		for letter in line:
			text_speed.start()
			text_box.add_text(letter)
			await text_speed.timeout
		text_timeout.set_wait_time(1.25)
		text_timeout.start()
		await text_timeout.timeout
		text_box.clear()
	text_timeout.set_wait_time(5)
	text_timeout.start()
	await text_timeout.timeout
	is_speaking = false
	text_box.clear()
