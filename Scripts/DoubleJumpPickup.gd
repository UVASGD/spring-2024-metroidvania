extends PickupBase

func _on_body_entered(body):
	print("hello!")
	if body.is_in_group("Player"):
		body.max_jumps += 1
		print("PICKUP!")
		queue_free()



