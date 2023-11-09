extends Node2D

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
	$canvas/Timer.start()
	_update_points()
	$canvas/Money.text = "$" + str(money)
	$canvas/Clock.text = str(clock)
	buttons = get_tree().get_nodes_in_group("MenuButtons")
	shops = get_tree().get_nodes_in_group("Shops")
	hunger = get_node("VirtPet/Hunger")
	clean = get_node("VirtPet/Clean")
	happy = get_node("VirtPet/Happy")

func _update_points():
	$canvas/Points.text = str(roundi(points))

func _on_button_pressed():
	points += click
	_update_points()

func _on_timer_timeout():
	$canvas/Timer.start()
	clock -= 1
	points += passiveEarn
	$canvas/Points.text = str(points)
	if clock == 0:
		money += 100
		clock = 120
		
	$canvas/Clock.text = str(clock)
	$canvas/Money.text = "$" + str(money)
	
	if clock%3 == 0:
		hunger.value -= 1
		clean.value -= 0.6
		happy.value -= 0.8
	qol = (hunger.value * clean.value * happy.value)/3

func _on_iap_menu_pressed():
	$canvas/IAPMenu/IAPBackground.visible = true
	$canvas/Back.visible = true
	$canvas/Back.disabled = false
	_toggle_menu_buttons()

func _on_upgrade_menu_pressed():
	$canvas/UpgradeMenu/UpgBackround.visible = true
	$MiscUp.visible = true
	$canvas/Back.visible = true
	$canvas/Back.disabled = false
	_toggle_menu_buttons()

func _on_passive_menu_pressed():
	$canvas/PassiveUpgrade/PasBackground.visible = true
	$canvas/Back.visible = true
	$canvas/Back.disabled = false
	_toggle_menu_buttons()

func _on_shmoney_store_pressed():
	$canvas/ShmoneyStore/ShStoreBackground.visible = true
	$canvas/Back.visible = true
	$canvas/Back.disabled = false
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
	$canvas/Back.visible = false
	$canvas/Back.disabled = true
	$canvas/IAPMenu/IAPBackground.visible = false
	$canvas/UpgradeMenu/UpgBackround.visible = false
	$canvas/PassiveUpgrade/PasBackground.visible = false
	$canvas/ShmoneyStore/ShStoreBackground.visible = false
	



