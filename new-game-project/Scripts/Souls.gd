extends RichTextLabel
@export var souls = 100;
func _on_main_souls_changed():
	self.text = str(souls);
