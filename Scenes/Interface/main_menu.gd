extends CanvasLayer

@onready var game_logo : Node = $GameLogo
@onready var buttons : Node = $MainMenuButtons

@onready var interactable : bool = false

@onready var world : Node = get_parent()

func _ready():
	game_logo.modulate = Color(1, 1, 1, 0)
	buttons.modulate = Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.tween_property(game_logo, "modulate", Color(1, 1, 1), 1)
	await tween.finished
	var tween2 = create_tween()
	tween2.tween_property(buttons, "modulate", Color(1, 1, 1), 0.5)
	await tween2.finished
	self.interactable = true

func remove_menu():
	var tween = create_tween()
	tween.tween_property(buttons, "modulate", Color(1, 1, 1, 0), 0.5)
	await tween.finished
	var tween2 = create_tween()
	tween2.tween_property(game_logo, "modulate", Color(1, 1, 1, 0), 1)
	await tween2.finished
	world.start_game()
	self.queue_free()
