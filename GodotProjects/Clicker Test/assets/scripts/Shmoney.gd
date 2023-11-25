extends CanvasLayer

var player
var buttons

func _ready():
	buttons = get_tree().get_nodes_in_group("ShmButtons")
	player = get_parent().get_node("canvas")
	if Global.Test:
		$ShopTitle.text = "[center]Money Shop"
		$Shmoney/Shmoney.set_texture(load("res://assets/UIassets/Icons/money.png"))
		$FlatShmUp0/Cost.text = ("Cost: $1.50")
		$FlatShmUp0/Icon.set_texture(load("res://assets/UIassets/Icons/money.png"))
		$FlatShmUp1/Cost.text = ("Cost: $5.00")
		$FlatShmUp1/Icon.set_texture(load("res://assets/UIassets/Icons/money.png"))
		$GShmucks/Cost.text = ("Cost: $50.00")
		$GShmucks/Icon.set_texture(load("res://assets/UIassets/Icons/money.png"))
		$TimeSkip/Cost.text = ("Cost: $100.00")
		$TimeSkip/Icon.set_texture(load("res://assets/UIassets/Icons/money.png"))

func _toggle_buttons():
	for i in buttons:
		if i.disabled:
			i.disabled = false
			i.visible = true
		else:
			i.disabled = true
			i.visible = false
	_update_shmoney()

func _on_shmoney_temp_bonus(price,bonus,time):
	if player.shmoney >= price:
		player.shmoney -= price
		player.pointmult = bonus
		player.bonustimer = time
		player._update_pmc()
	_update_shmoney()

func _on_golden_shmucks(price,index):
	var nameRef = get_child(index)
	if player.shmoney >= price:
		player.shmoney -= price
		player._update_pmc()
		player.gshmucks = true
		nameRef.modulate = Color(0,1,0)
		nameRef.get_child(0).text = ""
		var owned = Sprite2D.new()
		add_child(owned)
		var spot = nameRef.position
		owned.move_local_x(300)
		owned.move_local_y(spot.y + 60)
		owned.texture = load("res://assets/UIassets/Buttons/Owned.png")
		nameRef.disconnect("pressed",_on_golden_shmucks)
	_update_shmoney()

func _on_time_skip_pressed(price):
	if player.shmoney >= price:
		player.shmoney -= price
		player._update_pmc()
		player._skip_time()
	_update_shmoney()

func _update_shmoney():
	if Global.Test:
		$Shmoney.text = ("[center]$"+str(snapped(float(player.shmoney)/100,0.01)))
	else:
		$Shmoney.text = ("[center]"+ str(player.shmoney))
