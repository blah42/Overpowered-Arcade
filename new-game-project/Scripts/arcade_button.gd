extends TextureButton
@onready var subpanel = $Panel
func _ready() -> void:
	subpanel.visible = false
func _on_mouse_exited() -> void:
	subpanel.visible = false
	pass # Replace with function body.
func _on_mouse_entered() -> void:
	subpanel.visible = true
	pass # Replace with function body.
