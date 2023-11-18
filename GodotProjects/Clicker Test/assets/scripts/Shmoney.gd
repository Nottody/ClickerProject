extends CanvasLayer

var player
var buttons

func _ready():
	buttons = get_tree().get_nodes_in_group("ShmButtons")
	player = get_parent().get_node("canvas")

func _toggle_buttons():
	for i in buttons:
		if i.disabled:
			i.disabled = false
			i.visible = true
		else:
			i.disabled = true
			i.visible = false

func _on_shmoney_temp_bonus(price,bonus,time):
	if player.shmoney >= price:
		player.shmoney -= price
		player.pointmult = bonus
		player.bonustimer = time
		player._update_pmc()

func _on_golden_shmucks(price,index):
	var nameRef = get_child(index)
	if player.shmoney >= price:
		player.shmoney -= price
		player._update_pmc()
		player.gshmucks = true
		nameRef.modulate = Color(0,1,0)
		nameRef.disconnect("pressed",_on_golden_shmucks)

func _on_time_skip_pressed(price):
	if player.shmoney >= price:
		player.shmoney -= price
		player._update_pmc()
		player._skip_time()
