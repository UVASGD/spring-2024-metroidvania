extends EnemyBase
class_name EnemyKnight

func _physics_process(delta):
	#update_anims(SPEED)
	do_movement(delta)
	pass

func do_movement(delta):
	VELOCITY += SPEED * 15
	VELOCITY *= 0.9
	velocity.x = VELOCITY
	velocity += gravity_vector * gravity_magnitude * delta
	move_and_slide()
