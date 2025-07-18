extends RichTextLabel

func _on_main_souls_changed():
	$self.Text = str($Main.Souls);
