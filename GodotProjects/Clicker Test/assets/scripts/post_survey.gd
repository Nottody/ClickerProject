extends CanvasLayer

var Q1 = false
var Q2 = false
var Q3 = false

func _on_text_edit_text_changed():
	Q1 = true
	if Q1 == true && Q2 == true && Q3 == true:
		$SubmitButton.disabled = false

func _on_dog_slider_value_changed(value):
	Q2 = true
	if value == 0:
		$DogCare.set_text("[center]I actively disregarded my dog.")
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


	
