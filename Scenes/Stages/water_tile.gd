extends Area2D

@onready var anim_player : Node = $AnimationPlayer

func _physics_process(_delta):
	anim_player.play("waves")

func _on_area_entered(area):
	print("yah")
	var player = area.get_parent()
	print(player)
	player.can_jump = false
	player.actual_speed = 15
	print(player.can_jump)

func _on_area_exited(area):
	var player = area.get_parent()
	player.can_jump = true
	player.actual_speed = 30
