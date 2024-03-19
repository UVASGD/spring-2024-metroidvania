extends CharacterBody2D
class_name EnemyBase

@onready var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@onready var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var max_health : int = 100
@onready var current_health : int = max_health

@onready var SPEED = 0
@onready var VELOCITY = 0

func _on_hurtbox_area_entered(area):
	receive_damage(area.damage)

func receive_damage(damage):
	current_health -= damage
	print("I took " + str(damage) + " damage!")
