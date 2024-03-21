extends PickupBase

func _on_body_entered(body):
	print("YO")
	if body.is_in_group("Player"):
		body.set_dash()
		print("PICKUP!")
		queue_free()
