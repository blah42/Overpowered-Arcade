extends CharacterBody3D
# Minimum speed of the mob in meters per second.
# Maximum speed of the mob in meters per second.
@export var health = 50
@export var character_speed = 4
@export var path : PathFollow3D
@export var detector : Node3D
@export var characterPath : Path3D
var acquiring = false
var soulWorth = 10
var playing = false
@export var totalSouls = 0
#@onready var _nav_agent := $NavigationAgent3D as NavigationAgent3D

func _physics_process(_delta):
	if not playing:
		path.progress	+= character_speed*_delta
	for child in detector.get_children():
		if((not child.taken) and path.position.x<child.position.x and not acquiring):
			acquiring = true
			child.taken = true
			#print("Machine Detected")
			#nextPoint = path.add_point(,,)
			#print(child.position)
			characterPath.curve.add_point(child.position,Vector3(0,0,0),Vector3(0,0,0),(characterPath.curve.point_count-1))
			pass
		else:
			#print("Ignored")
			pass
	#print($GenericEnemies.Transform.position.x)

	if path.progress_ratio==1:
		queue_free()
	if health == 0:
		totalSouls += soulWorth
		queue_free()

# This function will be called from the Main scene.
func initialize(startPath:Path3D, chosenPath: PathFollow3D, detection: Node3D, souls):
	totalSouls = souls
	characterPath = startPath
	detector = detection
	path = chosenPath
	rotate_y(-PI)
