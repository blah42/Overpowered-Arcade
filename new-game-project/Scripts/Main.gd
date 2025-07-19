extends Node
signal make_menu_bar_visible;
signal make_menu_bar_invisible;
signal souls_changed;
signal score_changed;
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

