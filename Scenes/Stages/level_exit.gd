extends Area2D

@onready var world : Node = get_parent().get_parent()

func _on_area_entered(_area):
	world.end_level()
