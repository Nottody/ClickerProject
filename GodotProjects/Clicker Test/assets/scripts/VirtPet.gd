extends CanvasLayer

var player
var loge
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
	loge = get_parent().get_node("LogNode")
	toggleMenu = get_node("OpenPet")
	menu = get_node("PetMenu")
	hunger = get_node("Hunger")
	clean = get_node("Clean")
	happy = get_node("Happy")
	$Name.text = "[center]"+Global.DogName+"[/center]"

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
		loge._update_dog_spent(price)

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
		loge._update_dog_spent(price)

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
		loge._update_dog_spent(price)

func _upgrade_stat(stat):
	if stat == "hunger":
		hunmult = 1.2
	elif stat == "happy":
		hapmult = 1.2
	elif stat == "clean":
		clemult = 1.2

func _pet_animation_manager():
	if player.sleeping:
		player.sleep += 2
		if player.sleep >= 100:
			player.sleeping = false
			$DogAnim.play("HappyDog")
	if player.qol <= 300:
		$DogAnim.play("Misery")
		return
	elif happy.value <= 15:
		$DogAnim.play("SadDog")
		return
	elif hunger.value <= 15:
		$DogAnim.play("HungryDog")
		return
	elif clean.value <= 15:
		$DogAnim.play("StinkyDog")
		return
	elif player.sleep <= 15:
		$DogAnim.play("SleepDog")
		player.sleep += 1.5
		return
	elif player.qol >= 350:
		$DogAnim.play("HappyDog")
		return
	
