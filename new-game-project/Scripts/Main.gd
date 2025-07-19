extends Node
signal make_menu_bar_visible;
signal make_menu_bar_invisible;
signal souls_changed;
signal score_changed;
@onready var cam: Camera3D = $Camera3D

func _on_build_tile_button_pressed():
	#make click sound
	make_menu_bar_visible.emit();
	pass # Replace with function body.
func _on_build_success_airhockey():
	#make click sound
	
	make_menu_bar_invisible.emit();
	pass # Replace with function body.
func setSouls(value):
	$Camera3D/Control/HBoxContainer/Money.souls = value;
	if($Camera3D/Control/HBoxContainer/Money.souls <= 0): return; #Game over condition
	souls_changed.emit();
func setScore(value):
	$Camera3D/Control/HBoxContainer3/Score.score = value;
	score_changed.emit();
func _on_air_hockey_button_pressed():
	setScore(1000);
	var cost = 100;
	if($Camera3D/Control/HBoxContainer/Money.souls <=cost): return;
	setSouls($Camera3D/Control/HBoxContainer/Money.souls - cost);
	##
	## instatiate Air hockey here
	#3
	pass # Replace with function body.

	
const RAY_LENGTH = 100

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
		if(object.name == "button_floor_square_2"):
			print("button")
			
		
		#if(compstr.beginsWith("floor_alt")):
		#	print('highlight')
	pass
