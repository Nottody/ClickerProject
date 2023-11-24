extends CanvasLayer

var player
var dog

func _ready():
	player = get_parent().get_node("canvas")
	dog = get_parent().get_node("VirtPet")

func _on_visibility_changed():
	player._toggle_menu_buttons()
	dog.toggleMenu.disabled = true
	$Next.disabled = false

func _on_next_button_pressed():
	get_tree().change_scene_to_file("res://assets/Scenes/post_survey.tscn")
