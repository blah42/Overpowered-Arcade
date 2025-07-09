extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	#Example of scene name and function call
	var SceneName = "res://Scenes/level.tscn"
	change_level.call_deferred(load(SceneName))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_level(scene: PackedScene):
	# Remove old level if any.
	# $Level represents neutral node in scene
	var level = $Level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	# Add new level.
	level.add_child(scene.instantiate())
	print("level changed")
