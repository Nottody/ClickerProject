extends Node

# player stats
var points
var money
var abstract
# tracks the player's progress
var passive
var click
var iap_spent
# tracks player's interaction with the virtual pet
var qol
var dog_spent
# tracks real time\
var starttime
var time 
var curtime = Time.get_datetime_dict_from_system(false)
# one time use for dog name
var pet_name = "doggie"
# tracks how many times data has been logged
var loginc = 0
# variables to hold payer data
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
	playerconfig = {"Test":Global.Test,
					"PetName":Global.DogName,
					"Q1":Global.AvgHours,
					"Q2":Global.Idle,
					"Q3":Global.Idle}
	starttime = Time.get_datetime_dict_from_system(false)
	Global.PlayerDataArray = [{"Config":playerconfig}]
	$Timer.start()
	load_game()
	_get_data()
	
func _update_iap_spent(price):
	iap_spent += price
func _update_dog_spent(price):
	dog_spent += price

func _event_log(event_type: String, event_data: Dictionary ):
	var event : Dictionary = {
		'event': event_type,
		'data': event_data};
	Global.PlayerDataArray.append(event)
	
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
	points = player.points
	money = player.money
	abstract = player.shmoney
	click = player.click
	passive = player.passiveEarn
	qol = player.qol
	time = (str(Time.get_time_dict_from_system()["minute"] - starttime["minute"])+"-"+str(Time.get_time_dict_from_system()["second"]- starttime["second"]))
	curtime = Time.get_datetime_dict_from_system(false)
	playerdata = {"Name":pet_name,
					"Points":points,
					"Money":money,
					"IAPSpent":iap_spent,
					"DogSpent":dog_spent,
					"Abrstract":abstract,
					"Click":click,
					"Passive":passive,
					"QualityScore":qol,
					"Time":curtime }
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
	
func _get_data():
	$HTTPRequest.request(geturl)
	SEND = false
	
func _on_database_test():
	if SEND:
		return

	#date, time, cate, amount, desc = 12/11/22,08:15,INCOME,250,SOAP
	var datasend = ("?name="+pet_name+
					"&points="+str(points)+
					"&money="+str(money)+
					"&iapspent="+str(iap_spent)+
					"&dogspent="+str(dog_spent)+
					"&abstract="+str(abstract)+
					"&qscore="+str(qol)+
					"&click="+str(click)+
					"&passive="+str(passive)+
					"&time="+str(time)+
					"&sheetname="+sheetname) #LOOK into appscript's code doPost func to understand this 
	var headers = ["Content-Length: 0"]
	var posturl = apiurl+datasend
	print_debug(posturl)
	$HTTPRequest.request(posturl,headers,HTTPClient.METHOD_POST,"")
