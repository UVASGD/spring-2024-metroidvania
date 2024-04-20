extends Control

@onready var main_menu : Node = get_parent()

func _on_button_pressed():
	if main_menu.interactable:
		main_menu.remove_menu()

func _on_credits_pressed():
	if main_menu.interactable:
		pass # Replace with function body.

func _on_quit_pressed():
	if main_menu.interactable:
		get_tree().quit()
