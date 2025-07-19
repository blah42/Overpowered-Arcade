extends Node

@export var mob_scene: PackedScene

func _ready():
	#_on_timer_timeout()
	pass
	
func _on_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	#var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	var pathTracker = PathFollow3D.new()
	pathTracker.loop = false
	$SpawnPath.add_child(pathTracker)

	pathTracker.progress_ratio = 0
	mob.initialize(pathTracker.position, pathTracker)

	# Spawn the mob by adding it to the Main scene.
	#add_child(mob)
	var location = pathTracker.get_path()
	get_tree().get_root().get_node(location).add_child(mob)
