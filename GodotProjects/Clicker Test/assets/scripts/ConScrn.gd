extends CanvasLayer

var check = false

func _on_debug_button_pressed():
	get_tree().change_scene_to_file("res://assets/Scenes/MainGame.tscn")

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://assets/Scenes/prelim_survey.tscn")

func _on_consent_check_pressed():
	if check:
		check = false
		$ConsentCheck.set_texture_normal(load("res://assets/UIassets/Buttons/Unchecked Box.png"))
		$StartButton.disabled = true
	else:
		check = true
		$ConsentCheck.set_texture_normal(load("res://assets/UIassets/Buttons/Checked Box.png"))
		$StartButton.disabled = false
