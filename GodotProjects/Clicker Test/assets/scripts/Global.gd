extends Node

var DogName = "Peanut"
var Test
var AvgHours = 0
var Idle
var Micro
var ESV
var DogCare
var GameRating

var indexer = 0
var PlayerDataArray: Array = []
var playertestarray: Array = []

const apiurl = "https://script.google.com/macros/s/AKfycbxjMqg1W3YondiM7VNx0pMWOdC-MUzlUmIH7vJJxykx6NJPN0lpWkwZPEA_-NSNHLRqNQ/exec"

func _ready():
	print_debug("ready2")
	var gettest = HTTPRequest.new()
	add_child(gettest)
	var geturl = (apiurl + "?sheetname="+"Test")
	gettest.connect("request_completed",_on_HTTPRequest_request_complete)
	gettest.request(geturl)
	
func _on_HTTPRequest_request_complete(_result, _response_code, _headers, body):
	var data = body.get_string_from_utf8()
	data = data.replace("[{","").replace("}]","")
	data = data.split(":")
	print_debug(data)
	if int(data[1]) % 2 == 0:
		Test = false
	else:
		Test = true
	print_debug(Test)
	
func _on_config_request_complete(_result, _response_code, _headers, _body):
	pass
func _on_log_request_complete(_result, _response_code, _headers, _body):
	indexer += 1
	if indexer > 14:
		return
	_send_log_data(playertestarray,indexer)

func _send_config_data(dataset):
	var Request = HTTPRequest.new()
	add_child(Request)
	Request.connect("request_completed",_on_config_request_complete)
	for x in dataset:
		if "Config" in x:
			var i = x["Config"]
			var datasend = ("?name="+str(i["PetName"])+
							"&test="+str(i["Test"])+
							"&q1="+str(i["Q1"])+
							"&q2="+str(i["Q2"])+
							"&q3="+str(i["Q3"])+
							"&q4="+str(i["Q4"])+
							"&q5="+str(i["Q5"])+
							"&q6="+str(i["Q6"])+
							"&sheetname="+"SurveyData")
			var headers = ["Content-Length: 0"]
			var posturl = apiurl + datasend
			Request.request(posturl,headers,HTTPClient.METHOD_POST,"")
			indexer += 1


func _send_log_data(dataset,index):
	var Request1 = HTTPRequest.new()
	add_child(Request1)
	Request1.connect("request_completed",_on_log_request_complete)
	if "event" in dataset[index]:
			var d = dataset[index]
			var i = d["data"]
			var datasend = ("?name="+i["Name"]+
							"&points="+str(i["Points"])+
							"&money="+str(i["Money"])+
							"&iapspent="+str(i["IAPSpent"])+
							"&dogspent="+str(i["DogSpent"])+
							"&abstract="+str(i["Abrstract"])+
							"&qscore="+str(i["QualityScore"])+
							"&click="+str(i["Click"])+
							"&passive="+str(i["Passive"])+
							"&time="+str(i["Time"])+
							"&sheetname="+"PlayerData") #LOOK into appscript's code doPost func to understand this 
			var headers = ["Content-Length: 0"]
			var posturl = apiurl+datasend
			Request1.request(posturl,headers,HTTPClient.METHOD_POST,"")

