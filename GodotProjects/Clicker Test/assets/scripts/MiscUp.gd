extends CanvasLayer

var click
var priceMult = 1.1
var newPrice
var buttons
var points
var player
var nameRef
var childNode
# Called when the node enters the scene tree for the first time.
func _ready():
	buttons = get_tree().get_nodes_in_group("MiscButtons")
	player = get_parent().get_node("canvas")
	
func _toggle_buttons():
	for i in buttons:
		if i.disabled:
			i.disabled = false
			i.visible = true
		else:
			i.disabled = true
			i.visible = false
	
func _on_misc_shop_pressed(price,clickBonus,index,xpurchased):
	nameRef = get_child(index)
	if player.points >= price:
		player.points -= price
		player.click += clickBonus
		player._update_pmc()
		newPrice = roundi(price * priceMult)
		xpurchased += 1
		nameRef.tooltip_text = "This upgrade costs: " + str(newPrice)
		var label = nameRef.get_child(0)
		label.text = "	Cost: " + str(newPrice)
		nameRef.disconnect("pressed",_on_misc_shop_pressed)
		nameRef.connect("pressed",_on_misc_shop_pressed.bind(newPrice, clickBonus,index,xpurchased))
		if xpurchased > 0:
			childNode = nameRef.get_child(2)
			childNode.visible = true
			childNode.text = (str(xpurchased) + " owned")
		
func _on_otp_shop_pressed(price, clickBonus, index):
	nameRef = get_child(index)
	if player.points >= price:
		player.points -= price
		player.click += roundi((clickBonus * .1) * player.click)
		player._update_pmc()
		nameRef.modulate = Color(0,1,0)
		nameRef.disconnect("pressed",_on_otp_shop_pressed)
