extends CanvasLayer

var yes = false
var no = false 
var yes2 = false
var no2 = false
var hours

func _ready():
	$Yes.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
	$Yes2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
	$No.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
	$No2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))

func _on_h_slider_value_changed(value):
	$HourValue.set_text(str(value))
	if value == 20:
		$HourValue.set_text('20+')
	hours = value

func _on_yes_pressed():
	if yes:
		return
	else:
		yes = true
		$Yes.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
		no = false
		$No.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))

func _on_no_pressed():
	if no:
		return
	else:
		no = true
		$No.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
		yes = false
		$Yes.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))

func _on_yes_2_pressed():
	if yes2:
		return
	else:
		yes2 = true
		$Yes2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
		no2 = false
		$No2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))

func _on_no_2_pressed():
	if no2:
		return
	else:
		no2 = true
		$No2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioSel.png"))
		yes2 = false
		$Yes2.set_texture_normal(load("res://assets/UIassets/Buttons/RadioDe.png"))
