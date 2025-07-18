extends Node
@export var mob_scene: PackedScene

func _on_enemy_timer_timeout():
	print("Timeout")
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()
	print(mob_spawn_location.position)
	mob.initialize(mob_spawn_location.position)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
