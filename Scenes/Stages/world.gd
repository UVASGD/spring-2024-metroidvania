extends Node2D

@onready var player : PackedScene = preload("res://Scenes/Player/player.tscn")

@onready var beach_stage_2 : PackedScene = preload("res://Scenes/Stages/Beach/beach_stage_2.tscn")
@onready var forest_stage_1 : PackedScene = preload("res://Scenes/Stages/Forest/forest_stage_1.tscn")

@onready var current_stage : Node = null
@onready var player_inst : Node = null

func _ready():
	RenderingServer.set_default_clear_color(Color.LIGHT_SLATE_GRAY)
	spawn_stage(beach_stage_2)
	spawn_player()
	
func _process(_delta):
	if Input.is_action_just_pressed("test_input"):
		change_stage(forest_stage_1)
	
func change_stage(new_stage : PackedScene):
	if current_stage != null:
		get_tree().paused = true
		current_stage.queue_free()
		spawn_stage(new_stage)
		player_inst.global_position = Vector2(0, 0)
		get_tree().paused = false

func spawn_stage(stage : PackedScene):
	var stage_inst = stage.instantiate()
	stage_inst.global_position = Vector2(0, 0)
	add_child(stage_inst)
	current_stage = stage_inst

func spawn_player():
	player_inst = player.instantiate()
	player_inst.global_position = Vector2(0, 0)
	add_child(player_inst)
