extends NPCBase

@onready var anim_player : Node = $AnimationPlayer
@onready var audio : Node = $AudioStreamPlayer

@onready var win_screen : PackedScene = preload("res://Scenes/Interface/win_screen.tscn")

func _ready():
	super._ready()
	dialogue =	["Hello Doctor I am the final boss \nMuahahahahahahaha", 
				"Just kidding I am actually \nin love with you", 
				"We should get married!"]

func _process(_delta):
	super._process(_delta)
	anim_player.play("fly")
	if world:
		if world.player_inst:
			if world.player_inst.global_position.x > self.global_position.x:
				sprite.flip_h = false
			else:
				sprite.flip_h = true

func speak_text(text : Array):
	is_speaking = true
	for line in text:
		for letter in line:
			text_speed.start()
			audio.play()
			text_box.add_text(letter)
			await text_speed.timeout
		text_timeout.set_wait_time(1.25)
		text_timeout.start()
		await text_timeout.timeout
		text_box.clear()
	text_timeout.set_wait_time(5)
	text_timeout.start()
	win_game()
	await text_timeout.timeout
	is_speaking = false
	text_box.clear()


func win_game():
	var win_inst = win_screen.instantiate()
	add_child(win_inst)
