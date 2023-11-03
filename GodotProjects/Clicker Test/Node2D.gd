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

func _ready():
	$canvas/Timer.start()
	$canvas/Points.text = str(points)
	$canvas/Money.text = "$" + str(money)
	$canvas/Clock.text = str(clock)
	$canvas/UpgradeMenu.tooltip_text = "Upgrade Cost:" + str(upgradeCost)
	$canvas/PassiveUpgrade.tooltip_text = "Upgrade Cost:" + str(passiveCost)
	orgin = $canvas/SideMenu.position

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
	if $canvas/IAPMenu/IAPBackground.visible:
		$canvas/UpgradeMenu.disabled = false
		$canvas/PassiveUpgrade.disabled = false
		$canvas/IAPMenu/IAPBackground.visible = false
		
	else:
		$canvas/IAPMenu/IAPBackground.visible = true
		$canvas/UpgradeMenu.disabled = true
		$canvas/PassiveUpgrade.disabled = true

func _on_upgrade_menu_pressed():
	if $canvas/UpgradeMenu/UpgBackround.visible:
		$canvas/IAPMenu.disabled = false
		$canvas/PassiveUpgrade.disabled = false
		$canvas/UpgradeMenu/UpgBackround.visible = false
		
	else:
		$canvas/UpgradeMenu/UpgBackround.visible = true
		$canvas/IAPMenu.disabled = true
		$canvas/PassiveUpgrade.disabled = true

func _on_passive_menu_pressed():
	if $canvas/PassiveUpgrade/PasBackground.visible:
		$canvas/UpgradeMenu.disabled = false
		$canvas/IAPMenu.disabled = false
		$canvas/PassiveUpgrade/PasBackground.visible = false
		
	else:
		$canvas/PassiveUpgrade/PasBackground.visible = true
		$canvas/UpgradeMenu.disabled = true
		$canvas/IAPMenu.disabled = true

func _on_shmoney_store_pressed():
	if $canvas/ShmoneyStore/ShStoreBackground.visible:
		$canvas/ShmoneyStore/ShStoreBackground.visible = false
	else:
		$canvas/ShmoneyStore/ShStoreBackground.visible = true
