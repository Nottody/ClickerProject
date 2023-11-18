extends CanvasLayer

var passiveEarn
var priceMult = 1.1
var newPrice
var points
var childNode
var nameRef
var buttons
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	buttons = get_tree().get_nodes_in_group("PassButtons")
	player = get_parent().get_node("canvas")
	
func _toggle_buttons():
	for i in buttons:
		if i.disabled:
			i.disabled = false
			i.visible = true
		else:
			i.disabled = true
			i.visible = false
			
func _on_pass_shop_pressed(price,passive,index,xpurchased):
	nameRef = get_child(index)
	if player.points >= price:
		player.points -= price
		player.passiveEarn += passive
		player._update_pmc()
		newPrice = roundi(price * priceMult)
		xpurchased += 1
		nameRef.tooltip_text = "This upgrade costs: " + str(newPrice)
		var label = nameRef.get_child(0)
		label.text = "	Cost: " + str(newPrice)
		nameRef.disconnect("pressed",_on_pass_shop_pressed)
		nameRef.connect("pressed",_on_pass_shop_pressed.bind(newPrice,passive,index,xpurchased))
		if xpurchased > 0:
			childNode = nameRef.get_child(2)
			childNode.visible = true
			childNode.text = (str(xpurchased) + " owned")

func _on_otp_shop_pressed(price, passive, index):
	nameRef = get_child(index)
	if player.points >= price:	
		player.points -= price
		player.passiveEarn += roundi((passive * .1) * player.passiveEarn)
		player._update_pmc()
		nameRef.modulate = Color(0,1,0)
		nameRef.disconnect("pressed",_on_otp_shop_pressed)
