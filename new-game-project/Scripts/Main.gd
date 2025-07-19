extends Node
var arrow = load("res://assets/kenney_cursor-pixel-pack/Tiles/tile_0046.png")
var hand = load("res://assets/kenney_cursor-pixel-pack/Tiles/tile_0137.png")
var click_build = load("res://assets/kenney_ui-pack/Sounds/click-b.ogg")
var click_bar= load("res://assets/kenney_ui-pack/Sounds/click-a.ogg")
var air_hockey = preload("res://Scenes/AirHockey.tscn")
var arcade_machine = preload("res://Scenes/ArcadeMachine.tscn")
var basketball = preload("res://Scenes/BasketballGame.tscn")
var dance = preload("res://Scenes/DanceMachine.tscn")
var pinball = preload("res://Scenes/Pinball.tscn")
var vendingMachine = preload("res://Scenes/DanceMachine.tscn")
@export var selected_object = null;
signal make_menu_bar_visible;
signal make_menu_bar_invisible;
signal souls_changed;
signal score_changed;
@onready var cam: Camera3D = $Camera3D
@export var mob_scene: PackedScene

func _on_build_tile_button_pressed():
	#make click sound
	#AudioStreamPlayer.
	make_menu_bar_visible.emit();
	pass # Replace with function body.
#####################################################################################################
#Build objects
#####################################################################################################
func _on_build_success_airhockey():
	#make click sound
	var new_item = air_hockey.instantiate();
	new_item.position = selected_object.position;
	print(selected_object.position)
	new_item.position.y = new_item.position.y+.5 
	$ArcadeUnits.add_child(new_item)
	make_menu_bar_invisible.emit();
	pass # Replace with function body.
func _on_build_success_ddr():
	#make click sound
	var new_item = dance.instantiate();
	new_item.position = selected_object.position;
	print(selected_object.position)
	new_item.position.y = new_item.position.y+.5 
	$ArcadeUnits.add_child(new_item)
	make_menu_bar_invisible.emit();
	pass # Replace with function body.
func _on_build_success_basketball():
	#make click sound
	var new_item = basketball.instantiate();
	new_item.position = selected_object.position;
	print(selected_object.position)
	new_item.position.y = new_item.position.y+.5 
	$ArcadeUnits.add_child(new_item)
	make_menu_bar_invisible.emit();
	pass # Replace with function body.
func _on_build_success_arcade():
	#make click sound
	var new_item = arcade_machine.instantiate();
	new_item.position = selected_object.position;
	print(selected_object.position)
	new_item.position.y = new_item.position.y+.5 
	$ArcadeUnits.add_child(new_item)
	make_menu_bar_invisible.emit();
	pass # Replace with function body.
func _on_build_success_pinball():
	#make click sound
	var new_item = pinball.instantiate();
	new_item.position = selected_object.position;
	print(selected_object.position)
	new_item.position.y = new_item.position.y+.5 
	$ArcadeUnits.add_child(new_item)
	make_menu_bar_invisible.emit();
	pass # Replace with function body.
func _on_build_success_vend():
	#make click sound
	var new_item = vendingMachine.instantiate();
	new_item.position = selected_object.position;
	print(selected_object.position)
	new_item.position.y = new_item.position.y+.5 
	$ArcadeUnits.add_child(new_item)
	make_menu_bar_invisible.emit();
	pass # Replace with function body.
#####################################################################################################
# end Build objects
#####################################################################################################	
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
			match object.name:
				"Placement_tile":
					print(object.global_position)
					selected_object = colission;
					selected_object.position.x = object.global_position.x;
					selected_object.position.y = object.global_position.y;
					selected_object.position.z = object.global_position.z+.25;
					_on_build_tile_button_pressed()
				"AirHockey":
					print("Remove?")
				"Pinball":
					print("Remove?")
				"DanceMachine":
					print("Remove?")
				"arcadeMachine":
					print("Remove?")
				"basketballGame":
					print("Remove?")
				"VendingMachine":
					print("Remove?")
				_:
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


func _on_ddr_button_pressed() -> void:
	var cost = 50;
	if($Camera3D/Control/HBoxContainer/Money.souls <=cost): return;
	setSouls($Camera3D/Control/HBoxContainer/Money.souls - cost);
	_on_build_success_ddr()
	pass # Replace with function body.


func _on_basketball_button_pressed() -> void:
	var cost = 20;
	if($Camera3D/Control/HBoxContainer/Money.souls <=cost): return;
	setSouls($Camera3D/Control/HBoxContainer/Money.souls - cost);
	_on_build_success_basketball()
	pass # Replace with function body.


func _on_pinball_button_pressed() -> void:
	var cost = 5;
	if($Camera3D/Control/HBoxContainer/Money.souls <=cost): return;
	setSouls($Camera3D/Control/HBoxContainer/Money.souls - cost);
	_on_build_success_pinball()
	pass # Replace with function body.


func _on_vending_machine_button_pressed() -> void:
	var cost = 50;
	if($Camera3D/Control/HBoxContainer/Money.souls <=cost): return;
	setSouls($Camera3D/Control/HBoxContainer/Money.souls - cost);
	_on_build_success_vend()
	pass # Replace with function body.


func _on_arcade_button_pressed() -> void:
	var cost = 25;
	if($Camera3D/Control/HBoxContainer/Money.souls <=cost): return;
	setSouls($Camera3D/Control/HBoxContainer/Money.souls - cost);
	_on_build_success_arcade()
	pass # Replace with function body.
	


func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	#var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	var sourcePath = $SpawnPath
	var dupliPath = sourcePath.duplicate()
	add_child(dupliPath)
	var pathTracker = PathFollow3D.new()
	pathTracker.loop = false
	dupliPath.add_child(pathTracker)

	pathTracker.progress_ratio = 0
	mob.initialize(dupliPath, pathTracker, $ArcadeUnits)

	# Spawn the mob by adding it to the Main scene.
	#add_child(mob)
	var location = pathTracker.get_path()
	get_tree().get_root().get_node(location).add_child(mob)


func _on_timer_pay_up() -> void:
	setSouls($Camera3D/Control/HBoxContainer/Money.souls - $Camera3D/Control/HBoxContainer3/Timer.pay_ammount)
	pass # Replace with function body.
