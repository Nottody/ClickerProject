extends CanvasLayer

var player
var buttons
var toggleMenu
var menu
var orgin
var t = 0.0
var temp

func _ready():
	player = get_parent()
	toggleMenu = get_node("OpenPet")
	menu = get_node("PetMenu")
	orgin = menu.position


func _on_open_pet_pressed(button_pressed):
	if button_pressed:
		$SlideAnim.play("Close")
		#while menu.position != orgin:
		#	menu.move_local_x(1,0)
		toggleMenu.disconnect("pressed",_on_open_pet_pressed)
		toggleMenu.connect("pressed",_on_open_pet_pressed.bind(false))
	else:
		$SlideAnim.play("Slide")
		#while menu.position != (orgin - Vector2(600,0)):
			#menu.move_local_x(-1,0)
		toggleMenu.disconnect("pressed",_on_open_pet_pressed)
		toggleMenu.connect("pressed",_on_open_pet_pressed.bind(true))
			
