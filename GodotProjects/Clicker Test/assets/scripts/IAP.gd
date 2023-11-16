extends CanvasLayer

var buttons
var player

func _ready():
	buttons = get_tree().get_nodes_in_group("IAPButtons")
	player = get_parent().get_node("canvas")

func _toggle_buttons():
	for i in buttons:
		if i.disabled:
			i.disabled = false
			i.visible = true
		else:
			i.disabled = true
			i.visible = false

func _on_IAP_pressed(price,bonus):
	if player.money >= price:
		player.money -= price
		player.shmoney += bonus
		
func _on_dog_upgrade_pressed():
	pass
