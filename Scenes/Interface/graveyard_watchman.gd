extends NPCBase

func _ready():
	super._ready()
	dialogue =	["Oh you’re still alive?", 
				"I thought you’d been gilded \nlike the rest of them", 
				"Well, they didn’t say anything \nabout letting people out…"]

func _process(_delta):
	if world:
		if world.player_inst:
			if world.player_inst.global_position.x > self.global_position.x:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
