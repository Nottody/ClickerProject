extends CanvasLayer

var buttons
var player
var pet
var loge

func _ready():
	buttons = get_tree().get_nodes_in_group("IAPButtons")
	player = get_parent().get_node("canvas")
	pet = get_parent().get_node("VirtPet")
	loge = get_parent().get_node("LogNode")
	if Global.Test:
		$ShopTitle.text = "[center]Buy Money"
		$Shmoney/Shmoney.set_texture(load("res://assets/UIassets/Icons/money.png"))
		$FlatCliUp0/Icon.set_texture(load("res://assets/UIassets/Icons/money.png"))
		$FlatCliUp0/Bonus.text = " + $1.00"
		$FlatCliUp1/Icon.set_texture(load("res://assets/UIassets/Icons/money.png"))
		$FlatCliUp1/Bonus.text = " + $5.00"
		$FlatCliUp2/Icon.set_texture(load("res://assets/UIassets/Icons/money.png"))
		$FlatCliUp2/Bonus.text = " + $30.00"
		$FlatCliUp3/Icon.set_texture(load("res://assets/UIassets/Icons/money.png"))
		$FlatCliUp3/Bonus.text = " + $170.00"
		
		
func _toggle_buttons():
	for i in buttons:
		if i.disabled:
			i.disabled = false
			i.visible = true
		else:
			i.disabled = true
			i.visible = false
	_update_money()
	_update_shmoney()


func _on_IAP_pressed(price,bonus):
	if player.money >= price:
		player.money -= price
		player.shmoney += bonus
		loge._update_iap_spent(price)
		player._update_pmc()
		_update_money()
		_update_shmoney()

func _on_dog_upgrade_pressed(price,stat,index):
	var nameRef = get_child(index)
	if player.money >= price:
		player.money -= price
		player._update_pmc()
		loge._update_dog_spent(price)
		pet._upgrade_stat(stat)
		nameRef.set_texture_normal(load("res://assets/UIassets/Buttons/ClickUpgradeWIP.png"))
		nameRef.modulate = Color(0,1,0)
		nameRef.get_child(0).text = ""
		var owned = Sprite2D.new()
		add_child(owned)
		var spot = nameRef.position
		owned.move_local_x(440)
		owned.move_local_y(spot.y + 60)
		owned.texture = load("res://assets/UIassets/Buttons/Owned.png")
		nameRef.disconnect("pressed",_on_dog_upgrade_pressed)
		_update_money()
		_update_shmoney()

func _on_auto_upgrade_pressed(price,index):
	var nameRef = get_child(index)
	if player.money >= price:
		player.money -= price
		player._update_pmc()
		loge._update_dog_spent(price)
		player.auto = true
		nameRef.modulate = Color(0,1,0)
		nameRef.get_child(0).text = ""
		var owned = Sprite2D.new()
		add_child(owned)
		var spot = nameRef.position
		owned.move_local_x(440)
		owned.move_local_y(spot.y + 60)
		owned.texture = load("res://assets/UIassets/Buttons/Owned.png")
		nameRef.disconnect("pressed",_on_auto_upgrade_pressed)
		_update_money()
		_update_shmoney()

func _update_money():
	$Money.text = ("[center]$" + str(player.money))

func _update_shmoney():
	if Global.Test:
		$Shmoney.text = ("[center]$" + str(snapped(float(player.shmoney)/100,0.01)))
	else:
		$Shmoney.text = ("[center]" + str(player.shmoney))
