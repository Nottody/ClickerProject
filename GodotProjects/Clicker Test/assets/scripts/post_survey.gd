extends CanvasLayer

var Q1 = false
var Q2 = false
var Q3 = false

func _on_text_edit_text_changed():
	Q1 = true
	Global.ESV = $Background/TextEdit.get_text()
	if Q1 == true && Q2 == true && Q3 == true:
		$SubmitButton.disabled = false

func _on_dog_slider_value_changed(value):
	Q2 = true
	if value == 0:
		$DogCare.set_text("[center]I did not care for my dog at all.")
	elif value == 1:
		$DogCare.set_text("[center]I did not care very well for my dog.")
	elif value == 2:
		$DogCare.set_text("[center]I cared for my dog an adequate amount.")
	elif value == 3:
		$DogCare.set_text("[center]I cared for my dog quite well.")
	elif value == 4:
		$DogCare.set_text("[center]I kept my dog's stats in peak condition.")
	value += 1
	Global.DogCare = value
	if Q1 == true && Q2 == true && Q3 == true:
		$SubmitButton.disabled = false

func _on_game_slider_value_changed(value):
	Q3 = true
	value += 1
	$GameRating.set_text("[center]" + str(value))
	Global.GameRating = value
	if Q1 == true && Q2 == true && Q3 == true:
		$SubmitButton.disabled = false

func _on_submit_button_pressed():
	Global.PlayerDataArray[0]["Config"]["Q4"] = Global.ESV
	Global.PlayerDataArray[0]["Config"]["Q5"] = Global.DogCare
	Global.PlayerDataArray[0]["Config"]["Q6"] = Global.GameRating
	get_tree().change_scene_to_file("res://assets/Scenes/end_screen.tscn")
