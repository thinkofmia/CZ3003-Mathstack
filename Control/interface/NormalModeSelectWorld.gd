extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentSelectedWorld = "World #0"
onready var http : HTTPRequest = $MYHTTPRequest

# Called when the node enters the scene tree for the first time.
func _ready():
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
		changeBg(global.worldSelected.split("#")[1])
		currentSelectedWorld = global.worldSelected
		$NextButton/NextButtonLabel.text = "Enter " + global.worldSelected
		
func changeBg(selectedBg):
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
		
		
		
		
		
		
		
