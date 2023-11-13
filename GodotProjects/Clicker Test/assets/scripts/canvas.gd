extends CanvasLayer


var points = 0
var hunger 
var clean 
var happy 
var qol = 0.0
var money = 25
var passiveEarn = 0.0
var shmoney = 0
var click = 1
var clock = 120
var buttons
var shops

func _ready():
	$Timer.start()
	_update_pmc()
	buttons = get_tree().get_nodes_in_group("MenuButtons")
	shops = get_tree().get_nodes_in_group("Shops")
	hunger = get_parent().get_node("VirtPet/Hunger")
	clean = get_parent().get_node("VirtPet/Clean")
	happy = get_parent().get_node("VirtPet/Happy")


func _update_points():
	$Points.text = str(roundi(points))
func _update_money():
	$Money.text = "$" + str(money)
func _update_clock():
	$Clock.text = str(clock)
func _update_pmc():
	_update_clock()
	_update_money()
	_update_points()

func _on_button_pressed():
	points += click
	_update_points()

func _on_timer_timeout():
	$Timer.start()
	clock -= 1
	points += passiveEarn
	_update_pmc()
	if clock == 0:
		money += 100
		clock = 120
		_update_pmc()
	if clock%3 == 0:
		hunger.value -= 1
		clean.value -= 0.6
		happy.value -= 0.8
	qol = snappedf(((hunger.value * clean.value * happy.value)/50),0.01)

func _on_iap_menu_pressed():
	$IAPMenu/IAPBackground.visible = true
	$Back.visible = true
	$Back.disabled = false
	_toggle_menu_buttons()

func _on_upgrade_menu_pressed():
	$UpgradeMenu/UpgBackround.visible = true
	get_parent().get_node("MiscUp").visible = true
	$Back.visible = true
	$Back.disabled = false
	_toggle_menu_buttons()

func _on_passive_menu_pressed():
	$PassiveUpgrade/PasBackground.visible = true
	$Back.visible = true
	$Back.disabled = false
	_toggle_menu_buttons()

func _on_shmoney_store_pressed():
	$ShmoneyStore/ShStoreBackground.visible = true
	$Back.visible = true
	$Back.disabled = false
	_toggle_menu_buttons()
		
func _toggle_menu_buttons():
	for i in buttons:
		if i.disabled:
			i.disabled = false
		else:
			i.disabled = true
			
func _disable_shops():
	for i in shops:
		if i.visible:
			i.visible = false
			return

func _back_button():
	_toggle_menu_buttons()
	_disable_shops()
	$Back.visible = false
	$Back.disabled = true
	$IAPMenu/IAPBackground.visible = false
	$UpgradeMenu/UpgBackround.visible = false
	$PassiveUpgrade/PasBackground.visible = false
	$ShmoneyStore/ShStoreBackground.visible = false
	
