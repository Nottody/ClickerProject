extends Node2D

var points = 0
var hunger = 0
var soc = 0
var qol = 0
var money = 0
var shmoney = 0
var click = 1
var upgradeCost = 50
var passiveEarn = 0
var passiveCost = 100
var clock = 120
var orgin
var buttons

func _ready():
	$canvas/Timer.start()
	$canvas/Points.text = str(points)
	$canvas/Money.text = "$" + str(money)
	$canvas/Clock.text = str(clock)
	$canvas/UpgradeMenu.tooltip_text = "Upgrade Cost:" + str(upgradeCost)
	$canvas/PassiveUpgrade.tooltip_text = "Upgrade Cost:" + str(passiveCost)
	orgin = $canvas/SideMenu.position
	buttons = get_tree().get_nodes_in_group("MenuButtons")

func _on_button_pressed():
	points += click
	$canvas/Points.text = str(points)

func _on_click_upgrade_pressed():
	if points >= upgradeCost:
		points -= upgradeCost
		upgradeCost += (10 * click)
		click += 2
		$canvas/UpgradeMenu.tooltip_text = "Upgrade Cost:" + str(upgradeCost)
		$canvas/Points.text = str(points)


func _on_passive_upgrade_pressed():
	if points >= passiveCost:
		points -= passiveCost
		passiveCost += (10 * (passiveEarn+1))
		passiveEarn += 2
		$canvas/PassiveUpgrade.tooltip_text = "Upgrade Cost:" + str(passiveCost)
		$canvas/Points.text = str(points)

func _on_timer_timeout():
	$canvas/Timer.start()
	clock -= 1
	points += passiveEarn
	$canvas/Points.text = str(points)
	$canvas/Clock.text = str(clock)
	if clock == 0:
		money += 100
		clock = 120
		$canvas/Clock.text = str(clock)
		$canvas/Money.text = "$" + str(money)

func _on_side_menu_2_toggled(button_pressed):
	if button_pressed:
		if $canvas/SideMenu.position == orgin:
			$canvas/SideMenu.move_local_x(-450,false)
	else:
		$canvas/SideMenu.move_local_x(450,false)

func _on_iap_menu_pressed():
	$canvas/IAPMenu/IAPBackground.visible = true
	$canvas/Back.visible = true
	$canvas/Back.disabled = false
	_toggle_menu_buttons()

func _on_upgrade_menu_pressed():
	$canvas/UpgradeMenu/UpgBackround.visible = true
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

func _back_button():
	_toggle_menu_buttons()
	$canvas/Back.visible = false
	$canvas/Back.disabled = true
	$canvas/IAPMenu/IAPBackground.visible = false
	$canvas/UpgradeMenu/UpgBackround.visible = false
	$canvas/PassiveUpgrade/PasBackground.visible = false
	$canvas/ShmoneyStore/ShStoreBackground.visible = false
	
