extends Button

func _on_pressed() -> void:
	print("mouse")
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	pass # Replace with function body.
