extends CanvasLayer

var passive
var priceMuli = 1.1
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
