extends Node
@export var souls = 100;
@export var score = 0;
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
	souls
	make_menu_bar_invisible.emit();
	pass # Replace with function body.
func setSouls(value):
	souls = value;
	souls_changed.emit();
func setScore(value):
	score = value;
	score_changed.emit();
func _on_air_hockey_button_pressed():
	setScore(1000);
	pass # Replace with function body.
