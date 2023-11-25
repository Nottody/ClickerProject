extends CanvasLayer

var points = 0
var hunger 
var clean 
var happy 
var qol = 0.0
var sleep = 100
var sleeping = false
var pet
var money = 1000
var passiveEarn = 0.0
var shmoney = 100
var click = 1
var clock = 1200
var buttons
var shops
var loge
var auto = false
var gshmucks = false
var pointmult = 1.0
var basemult = 1.0
var passmult = 1.0
var bonustimer = 0

func _ready():
	$Timer.start()
	_update_pmc()
	loge = get_parent().get_node("LogNode")
	buttons = get_tree().get_nodes_in_group("MenuButtons")
	shops = get_tree().get_nodes_in_group("Shops")
	pet = get_parent().get_node("VirtPet")
	hunger = get_parent().get_node("VirtPet/Hunger")
	clean = get_parent().get_node("VirtPet/Clean")
	happy = get_parent().get_node("VirtPet/Happy")
	if Global.Test:
		$IAPMenu.set_texture_normal(load("res://assets/UIassets/Icons/money.png"))
		$ShmoneyStore/ShopName.text = "[center]Money Shop"

func _update_points():
	$Points.text = "[center]"+str(roundi(points))+"[/center]"
func _update_money():
	$Money.text = "$" + str(money)
func _update_clock():
	$Clock.text = str(clock)
func _update_shmoney():
	if Global.Test:
		$IAPMenu/Shmoney.text = "$"+str(snapped(float(shmoney)/100,0.01))
	else:
		$IAPMenu/Shmoney.text = str(shmoney)
func _update_pmc():
	_update_clock()
	_update_money()
	_update_points()
	_update_shmoney()
	
func _toggle_points():
	if $Points.visible:
		$Points.visible = false
	else:
		$Points.visible = true

func _on_button_pressed():
	points += ((click * basemult) * pointmult)
	$Button.play("boing")
	_update_points()

func _skip_time():
	points += (passiveEarn * 300)

func _auto_feed():
	if money >= 5:
		money -= 5
		hunger.value += 5
		happy.value += 4.2
		clean.value += 3.4
		loge._update_dog_spent(5)
	

func _on_timer_timeout():
	if points >= 1000000:
		get_parent().get_node("GameComp").visible = true
		$TextureButton.disabled = true
		return
	$Timer.start()
	clock -= 1
	points += ((passiveEarn/10)* passmult)
	_update_pmc()
	if clock == 0:
		money += 100
		clock = 1200
		_update_pmc()
	if clock%30 == 0:
		hunger.value -= 1
		clean.value -= 0.6
		happy.value -= 0.8
		pet._pet_animation_manager()
	qol = snappedf(((hunger.value * clean.value * happy.value)/50),0.01)
	if clock % 120 == 0:
		if auto:
			_auto_feed()
	_golden_shmucks()
	if bonustimer > 0:
		bonustimer -= 1
	else:
		pointmult = 1.0

func _golden_shmucks():
	if !gshmucks:
		return
	else:
		if randi_range(0,1170) == 1:
			$globAnim.play("Gshmoney")
	
func _on_gshmuck_pressed():
	$globAnim.play("gshmoneyreset")
	shmoney += randi_range(10,117)
	
func _on_main_button_pressed(button,score):
	get_parent().get_node(button).visible = true
	_background_tog(button)
	_pet_butt(false)
	_toggle_menu_buttons()
	if !score:
		_toggle_points()

func _toggle_menu_buttons():
	for i in buttons:
		if i.disabled:
			i.disabled = false
		else:
			i.disabled = true
	_back_off()

func _pet_butt(tog):
	if tog:
		get_parent().get_node("VirtPet/OpenPet").visible = true
		get_parent().get_node("VirtPet/OpenPet").disabled = false
	else:
		get_parent().get_node("VirtPet/OpenPet").visible = false
		get_parent().get_node("VirtPet/OpenPet").disabled = true

func _back_off():
	if $Back.disabled:
		$Back.disabled = false
		$Back.visible = true
	else:
		$Back.disabled = true
		$Back.visible = false

func _disable_shops():
	for i in shops:
		if i.visible:
			i.visible = false
			return

func _background_tog(back):
	if back == null:
		$IAPMenu/IAPBackground.visible = false
		$UpgradeMenu/UpgBackround.visible = false
		$PassiveUpgrade/PasBackground.visible = false
		$ShmoneyStore/ShStoreBackground.visible = false
	else:
		if back == "MiscUp":
			$UpgradeMenu/UpgBackround.visible = true
		elif back == "PassiveUp":
			$PassiveUpgrade/PasBackground.visible = true
		elif back == "IAP":
			$IAPMenu/IAPBackground.visible = true
		elif back == "Shmoney":
			$ShmoneyStore/ShStoreBackground.visible = true

func _back_button():
	_pet_butt(true)
	_toggle_menu_buttons()
	_disable_shops()
	_background_tog(null)
	if !$Points.visible:
		_toggle_points()
