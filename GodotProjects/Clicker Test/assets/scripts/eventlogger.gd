extends Node


var points
var passive
var click
var qol
var time = Time.get_datetime_dict_from_system(false)
var iap_spent
var dog_spent
var pet_name
var control
var player
var events: Array = []
var dirty = false
const playerdata = "res://savedata/playerdata.json"
const playerlog = "res://savedata/playerlog.json"
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("canvas")
	#$Timer.start()

func _progress_log():
	pass

func _event_log(event_type: String, event_data: Dictionary ):
	var event : Dictionary = {
		'event': event_type,
		'data': event_data};
	events.append(event)
	dirty = true
	
	
func save():
	if !dirty:
		return
	var file = FileAccess.open(playerlog, FileAccess.WRITE)
	file.store_string(str(events))
	dirty = false

func _on_timer_timeout():
	points = player.points
	click = player.click
	passive = player.passive
	qol = player.qol
	
