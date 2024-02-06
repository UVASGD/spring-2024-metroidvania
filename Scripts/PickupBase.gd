extends Area2D
class_name PickupBase

func _on_body_entered(body):
	print("hello!")
	if body.is_in_group("Player"):
		body.has_wall_jump = true
		print("PICKUP!")
		queue_free()
