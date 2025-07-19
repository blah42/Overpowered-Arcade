extends CharacterBody3D
# Minimum speed of the mob in meters per second.
# Maximum speed of the mob in meters per second.
@export var health = 50
@export var character_speed = 4
@export var path : PathFollow3D
@export var detector : Node3D
@export var characterPath : Path3D
var acquiring = false
#@onready var _nav_agent := $NavigationAgent3D as NavigationAgent3D

#var _nav_path_line: Line3D
func _physics_process(_delta):
	#if _nav_agent.is_navigation_finished():
		#return
#
	#var next_position := _nav_agent.get_next_path_position()
	#var offset := next_position - global_position
	#global_position = global_position.move_toward(next_position, _delta * character_speed)
#
	## Make the robot look at the direction we're traveling.
	## Clamp Y to 0 so the robot only looks left and right, not up/down.
	#offset.y = 0
	#if not offset.is_zero_approx():
		#look_at(global_position + offset, Vector3.UP)
	path.progress	+= character_speed*_delta
	#for child in detector.get_children():
		#if(child.taken):
			#print("Ignoring Machine")
			#pass
		#else:
			#acquiring = true
			#print("Machine Detected")
			##nextPoint = path.
			#characterPath.curve.addPoint()
			#pass
	#print(path.progress)
	if path.progress_ratio==1:
		queue_free()

# This function will be called from the Main scene.
func initialize(startPath:Path3D, chosenPath: PathFollow3D, detection: Node3D):
	# We position the mob by placing it at start_position
	# and rotate it towards player_position, so it looks at the player.
	characterPath = startPath
	detector = detection
	path = chosenPath
	#self.position = start_position
	#look_at_from_position(start_position, Vector3.FORWARD, Vector3.UP)
	# Rotate this mob randomly within range of -45 and +45 degrees,
	# so that it doesn't move directly towards the player.
	rotate_y(-PI)
	
	# We calculate a random speed (integer)
	#var random_speed = randi_range(min_speed, max_speed)
	# We calculate a forward velocity that represents the speed.
	#velocity = Vector3.FORWARD * random_speed
	# We then rotate the velocity vector based on the mob's Y rotation
	# in order to move in the direction the mob is looking.
	#velocity = velocity.rotated(Vector3.UP, rotation.y)

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
