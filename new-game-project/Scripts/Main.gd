extends Node
var arrow = load("res://assets/kenney_cursor-pixel-pack/Tiles/tile_0046.png")
var hand = load("res://assets/kenney_cursor-pixel-pack/Tiles/tile_0137.png")
var click_build = load("res://assets/kenney_ui-pack/Sounds/click-b.ogg")
var click_bar= load("res://assets/kenney_ui-pack/Sounds/click-a.ogg")
var air_hockey = preload("res://Scenes/AirHockey.tscn")
@export var selected_object = null;
signal make_menu_bar_visible;
signal make_menu_bar_invisible;
signal souls_changed;
signal score_changed;
@onready var cam: Camera3D = $Camera3D

func _on_build_tile_button_pressed():
	#make click sound
	#AudioStreamPlayer.
	make_menu_bar_visible.emit();
	pass # Replace with function body.
func _on_build_success_airhockey():
	#make click sound
	var new_air_hockey = air_hockey.instantiate();
	new_air_hockey.position = selected_object.position;
	print(selected_object.position)
	add_child(new_air_hockey)
	make_menu_bar_invisible.emit();
	pass # Replace with function body.
func setSouls(value):
	$Camera3D/Control/HBoxContainer/Money.souls = value;
	if($Camera3D/Control/HBoxContainer/Money.souls <= 0): return; #Game over condition
	souls_changed.emit();
func setScore(value):
	$Camera3D/Control/HBoxContainer3/Score.score = value;
	score_changed.emit();
	pass # Replace with function body.

	
const RAY_LENGTH = 100
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var space_state = $Camera3D.get_world_3d().direct_space_state
		var mousepos = get_viewport().get_mouse_position()
		var origin = cam.project_ray_origin(mousepos)
		var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true
		var colission = space_state.intersect_ray(query)
		if(colission):
			var object = colission.collider
			if(object.name == "Placement_tile"):
				print(object.global_position)
				selected_object = colission;
				selected_object.position.x = object.global_position.x;
				selected_object.position.y = object.global_position.y;
				selected_object.position.z = object.global_position.z+.25;
				_on_build_tile_button_pressed()
			elif(object.name == "AirHockey"):
				print("Remove?")
			else:
				make_menu_bar_invisible.emit()
				
			
func _physics_process(_delta):
	var space_state = $Camera3D.get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var colission = space_state.intersect_ray(query)
	if(colission):
		var object = colission.collider
		if(object.name == "Placement_tile"):
			Input.set_custom_mouse_cursor(hand)
		else:
			Input.set_custom_mouse_cursor(arrow)
			
			
			
		
		#if(compstr.beginsWith("floor_alt")):
		#	print('highlight')
	pass


func _on_air_hockey_button_pressed() -> void:
	var cost = 100;
	if($Camera3D/Control/HBoxContainer/Money.souls <=cost): return;
	setSouls($Camera3D/Control/HBoxContainer/Money.souls - cost);
	_on_build_success_airhockey()
	pass # Replace with function body.
