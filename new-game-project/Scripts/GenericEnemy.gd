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
var arcadeTitle : CharacterBody3D
var startingIndex = 0
var tempIdx = 0

func _physics_process(_delta):
	if not playing:
		$AnimationPlayer.play("walk",-1,1);
		path.progress	+= character_speed*_delta
	else:
		print(health)
		$AnimationPlayer.play("playing",-1,5);
		health -= soulDrain
		playTime -= 1
		if playTime == 0:
			finishedPlaying()
		
	if not acquiring and not playing:
		var obj = $"RayCast3D".get_collider()
		if(not obj==null):
			print("Arcade Detected")
			if(not obj.taken and not obj == arcadeTitle):
				print("Targeting Arcade")
				acquiring = true
				obj.taken = true
				arcadeTitle = obj
				soulDrain = obj.damage
				print("Object Position")
				print(obj.position)
				print("Position")
				print(path.position)
				#var closest = characterPath.curve.get_closest_point()
				#print("ClosestPoint")
				#print(closest)
				tempIdx = 0
				var closest = 10000
				for n in range(startingIndex, characterPath.curve.point_count):
					#print("Looking for point")
					#print(characterPath.curve.get_point_position(n))
					var diff = characterPath.curve.get_point_position(n).distance_to(path.position)
					if closest > diff:
						closest = diff
						tempIdx = n
					
						#var halfWay = characterPath.curve.sample(tempIdx, 0.5)
						#if path.position.distance_to()
				print(tempIdx)		
				characterPath.curve.add_point(obj.position, Vector3(0,0,0), Vector3(0,0,0), tempIdx+1)
				print("Full List")
				for n in characterPath.curve.point_count:
					print(characterPath.curve.get_point_position(n))
				startingIndex = tempIdx + 1
		#var camera3d = $Camera3D
		#var from = camera3d.project_ray_origin(path.position)
		#var to = from + camera3d.project_ray_normal(path.position) * 1000
		#for child in detector.get_children():
			
			#if((not child.taken) and path.position.x<child.position.x and not acquiring and not child == arcadeTitle):
				#acquiring = true
				#child.taken = true
				#arcadeTitle = child
				#soulDrain = child.damage
				##print("Machine Detected")
				##nextPoint = path.add_point(,,)
				##print(child.position)
				#characterPath.curve.add_point(child.position,Vector3(0,0,0),Vector3(0,0,0),(characterPath.curve.point_count-1))
				#break

	if acquiring:
		#print("Acquiring")
		if (characterPath.curve.get_point_position(tempIdx+1).distance_to(path.position)<0.5):
			acquiring = false
			playing = true
			tempIdx = 0
			$AnimationPlayer.play("playing",-1,5);
			print("Acquired")
	#print($GenericEnemies.Transform.position.x)

	if path.progress_ratio==1:
		queue_free()
	if health <= 0:
		$AnimationPlayer.play("death",-1,5);
		await get_tree().create_timer(.2).timeout
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
	#$Camera3D/RayCast3D.set_collision_mask_value(1, false)
	#$Camera3D/RayCast3D.set_collision_mask_value(2, true)

func finishedPlaying():
	print("Finished playing")
	playTime = 50
	playing = false
	arcadeTitle.taken = false
	#arcadeTitle = null
