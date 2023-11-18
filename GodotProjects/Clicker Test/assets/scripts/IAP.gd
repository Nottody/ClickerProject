extends CanvasLayer

var buttons
var player
var pet

func _ready():
	buttons = get_tree().get_nodes_in_group("IAPButtons")
	player = get_parent().get_node("canvas")
	pet = get_parent().get_node("VirtPet")

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
		player._update_pmc()
		
func _on_dog_upgrade_pressed(price,stat,index):
	var nameRef = get_child(index)
	if player.money >= price:
		player.money -= price
		player._update_pmc()
		pet._upgrade_stat(stat)
		nameRef.modulate = Color(0,1,0)
		nameRef.disconnect("pressed",_on_dog_upgrade_pressed)

func _on_auto_upgrade_pressed(price,index):
	var nameRef = get_child(index)
	if player.money >= price:
		player.money -= price
		player._update_pmc()
		player.auto = true
		nameRef.modulate = Color(0,1,0)
		nameRef.disconnect("pressed",_on_auto_upgrade_pressed)
