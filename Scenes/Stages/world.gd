extends Node2D

@onready var intro_screen : PackedScene = preload("res://Scenes/Interface/intro_screen.tscn")
@onready var main_menu : PackedScene = preload("res://Scenes/Interface/main_menu.tscn")
@onready var level_transition : PackedScene = preload("res://Scenes/Interface/level_transition.tscn")

@onready var player : PackedScene = preload("res://Scenes/Player/player.tscn")
@onready var player_inst : Node = null
@onready var game_start : bool = false

@onready var camera : Node = $Camera2D
@onready var audio_player : Node = $AudioStreamPlayer
@onready var audio_waves : Node = $AudioWaves

@onready var beach_stage_1 : PackedScene = preload("res://Scenes/Stages/1-Beach/beach_stage_1.tscn")
@onready var beach_stage_2 : PackedScene = preload("res://Scenes/Stages/1-Beach/beach_stage_2.tscn")
#@onready var beach_stage_3 : PackedScene = preload("res://Scenes/Stages/1-Beach/beach_stage_3.tscn")
@onready var forest_stage_1 : PackedScene = preload("res://Scenes/Stages/2-Forest/forest_stage_1.tscn")
@onready var forest_stage_2 : PackedScene = preload("res://Scenes/Stages/2-Forest/forest_stage_2.tscn")
#@onready var forest_stage_3 : PackedScene = preload("res://Scenes/Stages/2-Forest/forest_stage_3.tscn")
@onready var cathedral_stage_1 : PackedScene = preload("res://Scenes/Stages/6-Cathedral/cathedral_stage_1.tscn")
#@onready var cathedral_stage_2 : PackedScene = preload("res://Scenes/Stages/6-Cathedral/cathedral_stage_2.tscn")
#@onready var cathedral_stage_3 : PackedScene = preload("res://Scenes/Stages/6-Cathedral/cathedral_stage_3.tscn")

@onready var stages = [beach_stage_1, beach_stage_2, forest_stage_1, forest_stage_2, cathedral_stage_1]
@onready var stage_index : int = 0
@onready var current_stage : Node = null

@onready var title_music : AudioStreamMP3 = preload("res://Assets/Sounds/mainmenu.mp3")
@onready var title_to_beach_music : AudioStreamMP3 = preload("res://Assets/Sounds/beachtheme.mp3")
@onready var beach_music : AudioStreamMP3 = preload("res://Assets/Sounds/beachloop.mp3")
@onready var forest_music : AudioStreamMP3 = preload("res://Assets/Sounds/forestloop.mp3")
@onready var cathedral_music : AudioStreamMP3 = preload("res://Assets/Sounds/cathedral.mp3")
@onready var final_boss_music : AudioStreamMP3 = preload("res://Assets/Sounds/bossmusic.mp3")

@onready var music = [beach_music, beach_music, forest_music, forest_music, cathedral_music]

############################################ DEBUGGING ############################################

@onready var skip_intro : bool = false
@onready var skip_main_menu : bool = false

func _ready():
	camera.global_position = Vector2(0, -250)
	RenderingServer.set_default_clear_color(Color.LIGHT_SLATE_GRAY)
	spawn_stage(0)
	spawn_player()
	if !skip_intro:
		spawn_intro_screen()
	else:
		if !skip_main_menu:
			end_intro()
		else:
			start_game()

func _process(_delta):
	if Input.is_action_just_pressed("test_input"):
		#change_stage(3)
		#player_inst.global_position = Vector2(2160, -240)
		pass
	if player_inst and player_inst.game_start:
		camera.global_position = player_inst.global_position + Vector2(0, -40)
	if stage_index == 0:
		camera.limit_left = -480
	else:
		camera.limit_left = -48
	if stage_index == 0 and game_start == true and audio_player.playing == false:
		play_music(beach_music)

func start_game():
	game_start = true
	play_music(title_to_beach_music)
	if player_inst:
		player_inst.get_up()

func end_intro():
	play_music(title_music)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(camera, "global_position", Vector2(0, -50), 5)
	await tween.finished
	spawn_main_menu()

func play_music(audio : AudioStreamMP3):
	audio_player.stream = audio
	audio_player.play()

func spawn_main_menu():
	var main_menu_inst = main_menu.instantiate()
	add_child(main_menu_inst)

func spawn_intro_screen():
	var intro_inst = intro_screen.instantiate()
	add_child(intro_inst)

func end_level():
	if player_inst:
		player_inst.is_interacting = true
	var transition_inst = level_transition.instantiate()
	add_child(transition_inst)

func next_level():
	change_stage(stage_index + 1)

func allow_player_control():
	if player_inst:
		player_inst.SPEED = 0.5
	var timer := Timer.new()
	timer.wait_time = 1
	timer.one_shot = true
	timer.autostart = true
	add_child(timer)
	await timer.timeout
	timer.queue_free()
	if player_inst:
		player_inst.is_interacting = false

func change_stage(new_stage : int):
	if music[stage_index] != music[new_stage]:
		play_music(music[new_stage])
	stage_index = new_stage
	if current_stage != null:
		get_tree().paused = true
		current_stage.queue_free()
		spawn_stage(new_stage)
		player_inst.global_position = Vector2(-200, 0)
		get_tree().paused = false

func spawn_stage(stage : int):
	if stage_index == 0:
		audio_waves.play()
	else:
		audio_waves.stop()
	var stage_inst = stages[stage].instantiate()
	stage_inst.global_position = Vector2(0, 0)
	add_child(stage_inst)
	current_stage = stage_inst

func spawn_player():
	player_inst = player.instantiate()
	player_inst.global_position = Vector2(0, 0)
	add_child(player_inst)
