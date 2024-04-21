extends Control

@onready var main_menu : Node = get_parent()
@onready var label : Node = $Label
@onready var back_button : Node = $BackButton
@onready var container : Node = $VBoxContainer
@onready var play_button : Node = $VBoxContainer/Play
@onready var credits_button : Node = $VBoxContainer/Credits
@onready var quit_button : Node = $VBoxContainer/Quit

func _ready():
	label.modulate = Color(1, 1, 1, 0)
	back_button.modulate = Color(1, 1, 1, 0)
	container.modulate = Color(1, 1, 1)
	back_button.disabled = true
	play_button.disabled = false
	credits_button.disabled = false
	quit_button.disabled = false

func _on_button_pressed():
	if main_menu.interactable:
		main_menu.remove_menu()

func _on_credits_pressed():
	if main_menu.interactable:
		show_credits()

func _on_quit_pressed():
	if main_menu.interactable:
		get_tree().quit()

func show_credits():
	play_button.disabled = true
	credits_button.disabled = true
	quit_button.disabled = true
	var tween = create_tween()
	tween.tween_property(label, "modulate", Color(1, 1, 1), 1)
	var tween2 = create_tween()
	tween2.tween_property(back_button, "modulate", Color(1, 1, 1), 1)
	var tween3 = create_tween()
	tween3.tween_property(container, "modulate", Color(1, 1, 1, 0), 1)
	await tween2.finished
	back_button.disabled = false

func _on_back_button_pressed():
	back_button.disabled = true
	var tween = create_tween()
	tween.tween_property(label, "modulate", Color(1, 1, 1, 0), 1)
	var tween2 = create_tween()
	tween2.tween_property(back_button, "modulate", Color(1, 1, 1, 0), 1)
	var tween3 = create_tween()
	tween3.tween_property(container, "modulate", Color(1, 1, 1), 1)
	await tween3.finished
	play_button.disabled = false
	credits_button.disabled = false
	quit_button.disabled = false
	
