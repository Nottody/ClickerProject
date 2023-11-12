extends CanvasLayer

var DogName

func _on_button_pressed():
	DogName = $TextEdit.get_text()
	$doggie.set_text(DogName)
