extends Node

# player stats
var points
var money
var shmoney
# checks for test or control (false = control)
var test = false
# tracks the player's progress
var passive
var click
var iap_spent
# tracks player's interaction with the virtual pet
var qol
var dog_spent
# tracks real time
var time = Time.get_datetime_dict_from_system(false)
# one time use for dog name
var pet_name = "doggie"
# tracks how many times data has been logged
var loginc = 0
# variables to hold payer data
var player
var playerconfig = {}
var playerdata = {}
var surveydata = {}
var events: Array = []
var dirty = false
const playerlogs = "res://savedata/playerlogs.json"
const playersave = "res://savedata/playersave.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("canvas")
	playerconfig = {"Test":test,"PetName":pet_name}
	#playerconfig.append(surveydata)
	events = [{"Config":playerconfig}]
	#pet_name = ()
	#test = false
	$Timer.start()
	load_game()

func _event_log(event_type: String, event_data: Dictionary ):
	var event : Dictionary = {
		'event': event_type,
		'data': event_data};
	events.append(event)
	
func save():
	if !dirty:
		print_debug("returned")
		return
	print_debug("saving")
	var file = FileAccess.open(playerlogs, FileAccess.WRITE)
	for x in events:
		if x == events[0]:
			file.store_string("[")
		file.store_string(str(x))
		file.store_line(",")
		if x == events[-1]:
			file.store_string("]")
	file.close()
	dirty = false
	

func _save2():
	var file2 = FileAccess.open(playersave, FileAccess.WRITE)
	file2.store_string(str(playerdata))
	file2.close()

func load_game():
	if not FileAccess.file_exists("res://savedata/playersave.json"):
		return
		
	var file = FileAccess.open("res://savedata/playersave.json", FileAccess.READ)
	var playerload = file.get_line()
	print_debug(playerload)
	var data = playerload.split("{",true,0)
	if data.size() == 1:
		return
	data = data.slice(1,-1)
	print_debug(data)
	var datastring: String = data[0]
	print_debug(data)
	data = datastring.split(",",true,0)
	for i in data:
		print_debug(i)
		var string = i
		var array = string.split(":",true,0)
		for x in array:
			if "Points" in x:
				player.points = int(array[1])
			elif "Money" in x:
				player.money = int(array[1])
			elif "Abstract" in x:
				player.shmoney = int(array[1])
			elif "Click" in x:
				player.click = int(array[1])
			elif "Passive" in x:
				player.passiveEarn = int(array[1])
			elif "QualityScore" in x:
				player.qol = int(array[1])

func _on_timer_timeout():
	points = player.points
	money = player.money
	#iap_spent = player.iap_spent
	shmoney = player.shmoney
	click = player.click
	passive = player.passiveEarn
	qol = player.qol
	#dog_spent = player.dog_spent
	time = Time.get_datetime_dict_from_system(false)
	playerdata = {"Points": points,
					"Money":money,
					"Abrstract":shmoney,
					"Click":click,
					"Passive":passive,
					"QualityScore":qol,
					"Time":time }
	if points >= 10:
		if loginc < 1:
			if points < 100:
				_event_log("Log", playerdata)
				loginc = 1
				dirty = true
	if points >= 100:
		if loginc < 2:
			if points < 1000:
				_event_log("Log", playerdata)
				loginc = 2
				dirty = true
	if points >= 1000:
		if loginc < 3:
			if points < 10000:
				_event_log("Log", playerdata)
				loginc = 3
				dirty = true
	if points >= 10000:
		if loginc < 4:
			if points < 100000:
				_event_log("Log", playerdata)
				loginc = 4
				dirty = true
	if points > 100000:
		if loginc < 5:
			if points < 200000:	
				_event_log("Log", playerdata)
				loginc = 5
				dirty = true
	$Timer.start()
	save()
	_save2()

func _on_reset_pressed():
	var file = FileAccess.open("res://savedata/playersave.json",FileAccess.WRITE)
	file.store_string("")
	file.close()
	get_tree().change_scene_to_file("res://assets/Scenes/MainGame.tscn")
	
