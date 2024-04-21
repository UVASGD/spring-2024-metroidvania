extends NPCBase

@onready var audio : Node = $AudioStreamPlayer

func _ready():
	super._ready()
	dialogue =	["Oh you’re still alive?", 
				"I thought you’d been gilded \nlike the rest of them", 
				"Well, they didn’t say anything \nabout letting people out…"]

func _process(_delta):
	super._process(_delta)
	if world:
		if world.player_inst:
			if world.player_inst.global_position.x > self.global_position.x:
				sprite.flip_h = true
			else:
				sprite.flip_h = false

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
	await text_timeout.timeout
	is_speaking = false
	text_box.clear()
