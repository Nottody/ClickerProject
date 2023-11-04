extends CanvasLayer

var click
var buttons
var points
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	buttons = get_tree().get_nodes_in_group("MiscButtons")
	player = get_parent()
	
func _toggle_buttons():
	for i in buttons:
		if i.disabled:
			i.disabled = false
			i.visible = true
		else:
			i.disabled = true
			i.visible = false
	
func _on_misc_shop_pressed(price,clickBonus):
	if player.points >= price:
		player.points -= price
		player.click += clickBonus
		player._update_points()
		
	
