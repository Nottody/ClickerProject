extends CanvasLayer

#var DogName

func _on_dog_edit_text_changed():
	if $DogEdit.get_text().length() >= 3 && $DogEdit.get_text().length() <= 15:
		$PlayButton.disabled = false
	else:
		$PlayButton.disabled = true
	

func _on_play_button_pressed():
	Global.DogName = $DogEdit.get_text()
	get_tree().change_scene_to_file("res://assets/Scenes/MainGame.tscn")

#he he he ha. grrr
