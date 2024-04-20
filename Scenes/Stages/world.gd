extends Node2D

@onready var intro_screen : PackedScene = preload("res://Scenes/Interface/intro_screen.tscn")
@onready var main_menu : PackedScene = preload("res://Scenes/Interface/main_menu.tscn")

@onready var player : PackedScene = preload("res://Scenes/Player/player.tscn")

@onready var camera : Node = $Camera2D

@onready var beach_stage_1 : PackedScene = preload("res://Scenes/Stages/1-Beach/beach_stage_1.tscn")
@onready var beach_stage_2 : PackedScene = preload("res://Scenes/Stages/1-Beach/beach_stage_2.tscn")
#@onready var beach_stage_3 : PackedScene = preload("res://Scenes/Stages/1-Beach/beach_stage_3.tscn")
@onready var forest_stage_1 : PackedScene = preload("res://Scenes/Stages/2-Forest/forest_stage_1.tscn")
#@onready var forest_stage_2 : PackedScene = preload("res://Scenes/Stages/2-Forest/forest_stage_2.tscn")
#@onready var forest_stage_3 : PackedScene = preload("res://Scenes/Stages/2-Forest/forest_stage_3.tscn")
@onready var cathedral_stage_1 : PackedScene = preload("res://Scenes/Stages/6-Cathedral/cathedral_stage_1.tscn")
#@onready var cathedral_stage_2 : PackedScene = preload("res://Scenes/Stages/6-Cathedral/cathedral_stage_2.tscn")
#@onready var cathedral_stage_3 : PackedScene = preload("res://Scenes/Stages/6-Cathedral/cathedral_stage_3.tscn")

@onready var beach_stages = [beach_stage_1, beach_stage_2]
@onready var forest_stages = [forest_stage_1]
@onready var cathedral_stages = [cathedral_stage_1]
@onready var stages = [beach_stages, forest_stages, cathedral_stages]

@onready var current_stage : Node = null
@onready var player_inst : Node = null

############################################ DEBUGGING ############################################

@onready var skip_intro : bool = true

func _ready():
	camera.global_position = Vector2(0, -250)
	RenderingServer.set_default_clear_color(Color.LIGHT_SLATE_GRAY)
	spawn_stage(beach_stage_1)
	if !skip_intro:
		spawn_intro_screen()
	else:
		end_intro()
	#spawn_player()

func _process(_delta):
	if Input.is_action_just_pressed("test_input"):
		change_stage(forest_stage_1)
	if player_inst:
		camera.global_position = player_inst.global_position

func end_intro():
	var tween = create_tween()
	#tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(camera, "global_position", Vector2(0, -50), 5)
	await tween.finished
	spawn_main_menu()

func spawn_main_menu():
	var main_menu_inst = main_menu.instantiate()
	add_child(main_menu_inst)

func spawn_intro_screen():
	var intro_inst = intro_screen.instantiate()
	add_child(intro_inst)

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
