extends CanvasLayer

func _ready():
	Global._send_config_data(Global.PlayerDataArray)
	Global._send_log_data(Global.PlayerDataArray,Global.indexer)

func _on_endbutton_pressed():
	get_tree().quit()
	
func _on_timer_timeout():
	$EndButton.disabled = false
