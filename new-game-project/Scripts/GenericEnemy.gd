extends CharacterBody3D

func _physics_process(_delta):
	move_and_slide()
	
func initialize(start_position):
	# ...
	look_at_from_position(start_position, Vector3.FORWARD, Vector3.UP)
	# We calculate a random speed (integer)
	var random_speed = randi_range(0, 3)
	# We calculate a forward velocity that represents the speed.
	velocity = Vector3.FORWARD * random_speed
	# We then rotate the velocity vector based on the mob's Y rotation
	# in order to move in the direction the mob is looking.
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
