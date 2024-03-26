extends Node2D

@onready var beach_stage_2 : PackedScene = preload("res://Scenes/Stages/Beach/beach_stage_2.tscn")
@onready var forest_stage_1 : PackedScene = preload("res://Scenes/Stages/Forest/forest_stage_1.tscn")

@onready var current_stage

func _ready():
	RenderingServer.set_default_clear_color(Color.LIGHT_SLATE_GRAY)
	spawn_stage(beach_stage_2)
	
func _process(_delta):
	if Input.is_action_just_pressed("dash"):
		change_stage(forest_stage_1)
	
func change_stage(new_stage : PackedScene):
	get_tree().paused = true
	despawn_stage()
	spawn_stage(new_stage)
	get_tree().paused = false

func spawn_stage(stage : PackedScene):
	var stage_inst = stage.instantiate()
	add_child(stage_inst)
	current_stage = stage_inst

func despawn_stage():
	current_stage.queue_free()
