extends CharacterBody2D
class_name EnemyBase

const gravity_vector : Vector2 = Vector2(0, 1)
const gravity_magnitude : int = 800

@onready var max_health : int = 100
@onready var current_health : int = max_health

@onready var SPEED = 0
@onready var VELOCITY = 0

func _on_hurtbox_area_entered(area):
	receive_damage(area.damage)

func receive_damage(damage):
	self.current_health -= damage
	print(str(name) + " took " + str(damage) + " damage!")
	if current_health <= 0:
		print(str(name) + " has died!")
		self.queue_free()
