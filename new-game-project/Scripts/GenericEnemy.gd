extends CharacterBody3D
# Minimum speed of the mob in meters per second.
# Maximum speed of the mob in meters per second.
@export var health = 50
@export var character_speed = 4
@export var path : PathFollow3D
@export var detector : Node3D
@export var characterPath : Path3D
var soulDrain = 0
var acquiring = false
var soulWorth = 10
var playTime = 50
var playing = false
var totalSouls : String
#signal soulsAbsorbed
var arcadeTitle : CharacterBody3D

func _physics_process(_delta):
	if not playing:
		path.progress	+= character_speed*_delta
	else:
		print(health)
		health -= soulDrain
		playTime -= 1
		if playTime == 0:
			finishedPlaying()
		
	if not acquiring and not playing:
		for child in detector.get_children():
			if((not child.taken) and path.position.x<child.position.x and not acquiring and not child == arcadeTitle):
				acquiring = true
				child.taken = true
				arcadeTitle = child
				soulDrain = child.damage
				#print("Machine Detected")
				#nextPoint = path.add_point(,,)
				#print(child.position)
				characterPath.curve.add_point(child.position,Vector3(0,0,0),Vector3(0,0,0),(characterPath.curve.point_count-1))
				break
			else:
				#print("Ignored")
				pass
	if acquiring:
		print("Acquiring")
		if (characterPath.curve.get_point_position((characterPath.curve.point_count-2)).distance_to(path.position)<0.5):
			acquiring = false
			playing = true
			print("Acquired")
	#print($GenericEnemies.Transform.position.x)

	if path.progress_ratio==1:
		queue_free()
	if health == 0:
		finishedPlaying()
		get_parent().get_parent().get_parent().get_node(totalSouls).souls += soulWorth
		get_parent().get_parent().get_parent().get_node(totalSouls).text = str(get_parent().get_parent().get_parent().get_node(totalSouls).souls)
		queue_free()

# This function will be called from the Main scene.
func initialize(startPath:Path3D, chosenPath: PathFollow3D, detection: Node3D, souls: String):
	totalSouls = souls
	characterPath = startPath
	detector = detection
	path = chosenPath
	rotate_y(-PI)

func finishedPlaying():
	print("Finished playing")
	playTime = 50
	playing = false
	arcadeTitle.taken = false
	#arcadeTitle = null
