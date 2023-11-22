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
	Global.hours = value

func _on_yes_pressed():
	if Global.IdleT:
		return
	else:
		Global.IdleT = true
		$Yes.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
		Global.IdleF = false
		$No.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
		Q2 = true
	if Q2 && Q3 == true:
		$NextButton.disabled = false

func _on_no_pressed():
	if Global.IdleF:
		return
	else:
		Global.IdleF = true
		$No.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
		Global.IdleT = false
		$Yes.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
		Q2 = true
	if Q2 && Q3 == true:
		$NextButton.disabled = false

func _on_yes_2_pressed():
	if Global.MicroT:
		return
	else:
		Global.MicroT = true
		$Yes2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
		Global.MicroF = false
		$No2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
		Q3 = true
	if Q2 && Q3 == true:
		$NextButton.disabled = false

func _on_no_2_pressed():
	if Global.MicroF:
		return
	else:
		Global.MicroF = true
		$No2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
		Global.MicroT = false
		$Yes2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
		Q3 = true
	if Q2 && Q3 == true:
		$NextButton.disabled = false

func _on_next_button_pressed():
	get_tree().change_scene_to_file("res://assets/Scenes/dog_name.tscn")
