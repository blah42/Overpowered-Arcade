extends Node


func _on_main_score_changed():
	
	$self.Text = get_tree().get_first_node_in_group("scene").score;
