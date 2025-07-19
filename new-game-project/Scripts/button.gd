extends MeshInstance3D
signal object_clicked

var hover_material: ShaderMaterial
var original_material: Material

func _ready():
	original_material = material_override if material_override else get_surface_override_material(0)
	hover_material = ShaderMaterial.new()
	hover_material.shader = preload("res://shaders/tile_select_shader.gdshader")
	# required for hover to work 
	set_process_input(true)

func _input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Emit the clicked signal
			print("clicked")
			emit_signal("object_clicked")
			get_tree().set_input_as_handled()

func _on_mouse_entered():
	print("hovered")
	material_override = hover_material

func _on_mouse_exited():
	material_override = original_material
