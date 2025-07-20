extends Button
func _on_pressed() -> void:
	print("mouse")
	get_tree().change_scene_to_file("res://Scenes/StartScreen.tscn")
	get_node("/root/Main").free()
	pass # Replace with function body.
