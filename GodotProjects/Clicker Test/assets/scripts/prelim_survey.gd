extends CanvasLayer

var Q2 = false
var Q3 = false

func _ready():
	$Yes.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
	$Yes2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
	$No.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
	$No2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
func _on_h_slider_value_changed(value):
	$HourValue.set_text(str(value))
	if value == 20:
		$HourValue.set_text('20+')
	Global.AvgHours = value
func _on_yes_pressed():
	Q2 = true
	Global.Idle = true
	$Yes.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
	$No.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
	if Q2 && Q3 == true:
		$NextButton.disabled = false
func _on_no_pressed():
	Q2 = true
	Global.Idle = false
	$No.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
	$Yes.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
	if Q2 && Q3 == true:
		$NextButton.disabled = false
func _on_yes_2_pressed():
	Q3 = true
	Global.Micro = true
	$Yes2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
	$No2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
	if Q2 && Q3 == true:
		$NextButton.disabled = false
func _on_no_2_pressed():
	Q3 = true
	Global.Micro = false
	$No2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
	$Yes2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
	if Q2 && Q3 == true:
		$NextButton.disabled = false
func _on_next_button_pressed():
	get_tree().change_scene_to_file("res://assets/Scenes/dog_name.tscn")
