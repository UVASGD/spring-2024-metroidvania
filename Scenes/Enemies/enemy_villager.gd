extends EnemyBase
class_name EnemyVillager

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

func attack():
	anim_player.play("attack")

func _on_detect_player_area_entered(_area):
	attack()
