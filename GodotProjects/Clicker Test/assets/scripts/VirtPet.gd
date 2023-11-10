extends CanvasLayer

var player
var buttons
var toggleMenu
var menu
var hunger
var clean
var happy
#var money

func _ready():
	player = get_parent().get_node("canvas")
	toggleMenu = get_node("OpenPet")
	menu = get_node("PetMenu")
	hunger = get_node("Hunger")
	clean = get_node("Clean")
	happy = get_node("Happy")
	#money = player.money

func _on_open_pet_pressed(button_pressed):
	if button_pressed:
		$SlideAnim.play("Close")
		player._toggle_menu_buttons()
		toggleMenu.set_texture_normal(load("res://assets/UIassets/Buttons/SideButtonWIP.png"))
		toggleMenu.disconnect("pressed",_on_open_pet_pressed)
		toggleMenu.connect("pressed",_on_open_pet_pressed.bind(false))
	else:
		$SlideAnim.play("Slide")
		player._toggle_menu_buttons()
		toggleMenu.set_texture_normal(load("res://assets/UIassets/Buttons/SideButtonWIP2.png"))
		toggleMenu.disconnect("pressed",_on_open_pet_pressed)
		toggleMenu.connect("pressed",_on_open_pet_pressed.bind(true))
			
func _on_hunger_purchase(price):
	if player.money >= price:
		if price > 5:
			player.money -= price
			hunger.value += 25
			happy.value += 15
		else:
			player.money -= price
			hunger.value += 20
		player._update_money()
			
func _on_clean_purchase(price):
	if player.money >= price:
		if price > 5:
			player.money -= price
			clean.value += 25
			hunger.value += 15
		else:
			player.money -= price
			clean.value += 20
		player._update_money()
	
func _on_happy_purchase(price):
	if player.money >= price:
		if price > 5:
			player.money -= price
			happy.value += 25
			clean.value += 15
		else:
			player.money -= price
			happy.value += 20
		player._update_money()



