extends Node

@export var mob_scene: PackedScene

func _on_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")



	mob.initialize($StartLocation.position, mob_spawn_location)

	# Spawn the mob by adding it to the Main scene.
	#add_child(mob)
	$SpawnPath/SpawnLocation.add_child(mob)
