extends RichTextLabel
@export var souls = 1000;
func _ready() -> void:
	self.text = str(souls);
func _on_main_souls_changed():
	self.text = str(souls);
