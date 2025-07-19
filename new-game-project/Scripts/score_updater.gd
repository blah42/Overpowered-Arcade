extends Node
@export var score = 0;
func _on_main_score_changed():
	
	self.text = str(score);
