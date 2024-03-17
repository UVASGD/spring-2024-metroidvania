extends CharacterBody2D
class_name EnemyBase

@onready var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@onready var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var max_health : int
@onready var current_health : int

@onready var SPEED = 0
@onready var VELOCITY = 0
