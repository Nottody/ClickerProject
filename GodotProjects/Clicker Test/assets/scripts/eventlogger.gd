extends Node

# player stats
var points
var money
var abstract
# tracks the player's progress
var passive
var click
var iap_spent = 0
# tracks player's interaction with the virtual pet
var qol
var dog_spent = 0
# tracks real time\
var starttime
var time 
var curtime = Time.get_datetime_dict_from_system(false)
# one time use for dog name
var pet_name = ""
# tracks how many times data has been logged
var loginc = 0
# variables to hold payer data
var end
var player
var playerconfig = {}
var playerdata = {}
var surveydata = {}
#var events
var dirty = false
const playerlogs = "res://savedata/playerlogs.json"
const playersave = "res://savedata/playersave.json"
const apiurl = "https://script.google.com/macros/s/AKfycbzGi5ace_iTJUVOLphfxXbqSGvFZ6k4tm7J0ONCEzWbADzdaZuEhC6Do91iEx8a8i-wkQ/exec"

var sheetname = "PlayerData"
var SEND
var geturl = (apiurl + "?sheetname=" +sheetname)

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("canvas")
	end = get_parent().get_node("GameComp/Next")
	playerconfig = {"PetName":Global.DogName,
					"Test":Global.Test,
					"Q1":Global.AvgHours,
					"Q2":Global.Idle,
					"Q3":Global.Idle}
	starttime = Time.get_datetime_dict_from_system(false)
	Global.PlayerDataArray = [{"Config":playerconfig}]
	$Timer.start()
	#load_game()
	
func _update_iap_spent(price):
	iap_spent += price
func _update_dog_spent(price):
	dog_spent += price

func _event_log(event_type: String, event_data: Dictionary ):
	var event : Dictionary = {
		'event': event_type,
		'data': event_data};
	Global.PlayerDataArray.append(event)

func _event_log_test(event_type: String, event_data: Dictionary ):
	var event : Dictionary = {
		'event': event_type,
		'data': event_data};
	Global.playertestarray.append(event)

func save():
	if !dirty:
		print_debug("returned")
		return
	print_debug("saving")
	var file = FileAccess.open(playerlogs, FileAccess.WRITE)
	for x in Global.PlayerDataArray:
		if x == Global.PlayerDataArray[0]:
			file.store_string("[")
		file.store_string(str(x))
		file.store_line(",")
		if x == Global.PlayerDataArray[-1]:
			file.store_string("]")
	file.close()
	print_debug(Global.PlayerDataArray)
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
			elif "IAPSpent" in x:
				iap_spent = int(array[1])
			elif "DogSpent" in x:
				dog_spent = int(array[1])
			elif "Abstract" in x:
				player.shmoney = int(array[1])
			elif "Click" in x:
				player.click = int(array[1])
			elif "Passive" in x:
				player.passiveEarn = int(array[1])
			elif "QualityScore" in x:
				player.qol = int(array[1])

func _on_timer_timeout():
	points = roundi(player.points)
	money = player.money
	abstract = player.shmoney
	click = player.click
	passive = player.passiveEarn
	qol = player.qol
	time = (str(Time.get_time_dict_from_system()["hour"])+ "-" +str(Time.get_time_dict_from_system()["minute"])+"-"+str(Time.get_time_dict_from_system()["second"]))
	curtime = Time.get_datetime_dict_from_system(false)
	playerdata = {"Name":Global.DogName,
					"Points":points,
					"Money":money,
					"IAPSpent":iap_spent,
					"DogSpent":dog_spent,
					"Abrstract":abstract,
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
	if points >= 100000:
		if loginc < 5:
			if points < 200000:	
				_event_log("Log", playerdata)
				loginc = 5
				dirty = true
	if points >= 200000:
		if loginc < 6:
			if points < 300000:
				_event_log("Log", playerdata)
				loginc = 6
				dirty = true
	if points >= 300000:
		if loginc < 7:
			if points < 400000:
				_event_log("Log", playerdata)
				loginc = 7
				dirty = true
	if points >= 400000:
		if loginc < 8:
			if points < 500000:
				_event_log("Log", playerdata)
				loginc = 8
				dirty = true
	if points >= 500000:
		if loginc < 9:
			if points < 600000:
				_event_log("Log", playerdata)
				loginc = 9
				dirty = true
	if points >= 600000:
		if loginc < 10:
			if points < 700000:
				_event_log("Log", playerdata)
				loginc = 10
				dirty = true
	if points >= 700000:
		if loginc < 11:
			if points < 800000:
				_event_log("Log", playerdata)
				loginc = 11
				dirty = true
	if points >= 800000:
		if loginc < 12:
			if points < 900000:
				_event_log("Log", playerdata)
				loginc = 12
				dirty = true
	if points >= 900000:
		if loginc < 13:
			if points < 1000000:
				_event_log("Log", playerdata)
				loginc = 13
				dirty = true
	if points >= 1000000:
		if loginc < 14:
			_event_log("Log", playerdata)
			loginc = 14
			dirty = true
			end.disabled = false
	$Timer.start()
	save()
	_save2()

func _on_reset_pressed():
	var file = FileAccess.open("res://savedata/playersave.json",FileAccess.WRITE)
	file.store_string("")
	file.close()
	get_tree().change_scene_to_file("res://assets/Scenes/MainGame.tscn")

