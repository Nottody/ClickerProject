extends CanvasLayer

var player
var buttons
var toggleMenu
var menu
var hunger
var clean
var happy
var hunmult = 1.0
var clemult = 1.0
var hapmult = 1.0
var lilcare = 15 
var medcare = 20
var bigcare = 25

func _ready():
	player = get_parent().get_node("canvas")
	toggleMenu = get_node("OpenPet")
	menu = get_node("PetMenu")
	hunger = get_node("Hunger")
	clean = get_node("Clean")
	happy = get_node("Happy")

func _on_open_pet_pressed(button_pressed):
	if button_pressed:
		$SlideAnim.play("Close")
		player._toggle_menu_buttons()
		player._back_off()
		toggleMenu.set_texture_normal(load("res://assets/UIassets/Buttons/SideButtonWIP.png"))
		toggleMenu.disconnect("pressed",_on_open_pet_pressed)
		toggleMenu.connect("pressed",_on_open_pet_pressed.bind(false))
	else:
		$SlideAnim.play("Slide")
		player._toggle_menu_buttons()
		player._back_off()
		toggleMenu.set_texture_normal(load("res://assets/UIassets/Buttons/SideButtonWIP2.png"))
		toggleMenu.disconnect("pressed",_on_open_pet_pressed)
		toggleMenu.connect("pressed",_on_open_pet_pressed.bind(true))
			
func _on_hunger_purchase(price):
	if player.money >= price:
		if price > 5:
			player.money -= price
			hunger.value += (bigcare * hunmult)
			happy.value += (lilcare * hunmult)
		else:
			player.money -= price
			hunger.value += (medcare * hunmult)
		player._update_pmc()
			
func _on_clean_purchase(price):
	if player.money >= price:
		if price > 5:
			player.money -= price
			clean.value += (bigcare * clemult)
			hunger.value += (lilcare * clemult)
		else:
			player.money -= price
			clean.value += (medcare * clemult)
		player._update_pmc()
	
func _on_happy_purchase(price):
	if player.money >= price:
		if price > 5:
			player.money -= price
			happy.value += (bigcare * hapmult)
			clean.value += (lilcare * hapmult)
		else:
			player.money -= price
			happy.value += (medcare * hapmult)
		player._update_pmc()

func _upgrade_stat(stat):
	if stat == "hunger":
		hunmult = 1.2
	elif stat == "happy":
		hapmult = 1.2
	elif stat == "clean":
		clemult = 1.2

