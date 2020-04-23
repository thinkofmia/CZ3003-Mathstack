extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bg
var currentSelectedWorld = "World #0"
onready var http : HTTPRequest = $MYHTTPRequest
onready var http2 : HTTPRequest = $MYHTTPRequest2

# Called when the node enters the scene tree for the first time.
func _ready():
	bg = $Background
	Firebase.update_document("UnlockedCharactersData/%s" % str(global.username), {"data" : {"values" :[{'integerValue':1}]}}, http2)
	#Performance Check
	if (testPerformance.performanceCheck):
		testPerformance.startTime()
	$PlayBoard/CompletionBox/ProgressBar.value = 0
	global.modeSelected = "Normal Mode"
	Firebase.get_document("SaveData/%s" % str(global.username), http)

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.worldSelected != currentSelectedWorld:
		#Firebase.save_document("normalmodeprogress",{"progress":{"integerValue":6}}, http)
		#changeBg(global.worldSelected.split("#")[1])
		changeBg()
		currentSelectedWorld = global.worldSelected
		$NextButton/NextButtonLabel.text = "Enter " + global.worldSelected


#Change Background
func changeBg():
	#Set Background
	bg.setBackground()
	changeMaterial()


#Change Box Material
func changeMaterial():
	var material = $Background/ControlBox
	match global.worldSelected:
		"World #1":
			material.color = Color(0, 0, 0.8, 1)
		"World #2":
			material.color = Color(0, 0.8, 0, 1)
		"World #3":
			material.color = Color(0, 0.8, 0, 1)
		"World #4":
			material.color = Color(0, 0, 0.8, 1)
		"World #5":
			material.color = Color(0.3, 0.3, 0.3, 1)
		"World #6":
			material.color = Color(0.8, 0.8, 0, 1)
		"World #7":
			material.color = Color(0.8, 0, 0, 1)
		"World #8": ###
			material.color = Color(1, 0, 0, 1)
		"World #9":
			material.color = Color(0.3, 0.3, 0.3, 1)
		"World #10":
			material.color = Color(0.8, 0.8, 0.8, 1)
		_:
			material.color = Color(1, 1, 0, 1)


func changeBg2(selectedBg):
	#Hide all bg
	$Background2.hide()
	$Background3.hide()
	$Background4.hide()
	$Background5.hide()
	$Background6.hide()
	
	match int(selectedBg):
		1:
			$TemplateScreen/TextureRect.show()
		2:
			$Background2.show()
		3:
			$Background3.show()
		4:
			$Background4.show()
		5:
			$Background5.show()
		6:
			$Background6.show()


func _on_NextButton_pressed():
	for unlock in global.characterUnlockList:
		print(unlock.associatedWorld)
		print(global.worldSelected)
		if unlock.associatedWorld == global.worldSelected:
			global.normalModeCharacterSelected = unlock.characterName
			break
	get_tree().change_scene("res://View/gameModes/NormalModeSelectDifficulty.tscn")


func _on_MYHTTPRequest_request_completed(result, response_code, headers, body):
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		#error
		404:
			return
		#success
		200:
			global.save = result_body.fields
			global.updateUnlockCharsList(result_body.fields)
			
			calculateAndSetValueForProgress()
			

func calculateAndSetValueForProgress():
	var total = 30.0
	var userProgress = 0.0
	for i in range(1,11):
		userProgress = userProgress + int(global.save['World' + str(i)].stringValue)
		
	var finalValue = (userProgress / total) * 100
	$PlayBoard/CompletionBox/ProgressBar.value = finalValue
	
	for y in range(1,11):
		var userProgressDist = int(global.save['World' + str(y)].stringValue)
		var path = ""
		if (y % 2 != 0):
			path = "PlayBoard/ScrollContainer/HBoxContainer/LeftContainer/WorldButton #" + str(y)
		else:
			path = "PlayBoard/ScrollContainer/HBoxContainer/RightContainer/WorldButton #" + str(y)
		
		if (userProgressDist == 3):
			get_node(path).icon = load("res://Model/Object/Tick.png")
	#Test Performane
	if (testPerformance.performanceCheck):
		print("Performance Test: Normal Mode - Worlds Load")
		testPerformance.getTimeTaken()
		
		
		
		
		
		
		


func _on_MYHTTPRequest2_request_completed(result, response_code, headers, body):
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	print(response_code)
	print(result_body)
	match response_code:
		#error
		404:
			print("Error")
			print(result_body)
			return
		#success
		200:
			print("Success")
