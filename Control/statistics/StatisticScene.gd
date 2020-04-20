extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var http : HTTPRequest = $HTTPRequest
onready var http2 : HTTPRequest = $HTTPRequest2
onready var http3: HTTPRequest = $HTTPRequest3
var totalNumOfStudents = -1
var totalNumOfCompletions = -1
var totalScoreCompletions = -1
var totalScoreAverage = 0
var students = []
var classId= -1
var studentsFullProgressDetails = []


# Called when the node enters the scene tree for the first time.
func _ready():
	#Performance Test
	if (testPerformance.performanceCheck):
		testPerformance.startTime()
	if global.customViewingStats:
		doViewingCustomStatsSteps()
	else:
		Firebase.get_document("%s" % "users", http)
		Firebase.get_document("%s" % "SaveData",http2)


func doViewingCustomStatsSteps():
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer.remove_child($TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/AverageLabel)
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer.remove_child($TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/AverateScoreLabel)
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer.remove_child($TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/ProgressBar)
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/PercentageCompletionLabel.remove_child($TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/PercentageCompletionLabel)
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/PercentageCompletionLabel.remove_and_skip()
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/TitleLabel.text = "Quiz Name: " + global.customTitle 
	Firebase.get_document("CustomScore_" + global.customTitle,http3)

func constructListWithData(listData):
	$TextureRect/MarginContainer/MarginContainer/VBoxContainer/ItemList.clear()
	for item in listData:
		var titleString = item + "  ----  " + "Not Started"
		for full in studentsFullProgressDetails:
			if (full.name.split("/")[-1] == item):
				if (full.fields['World' + str(global.statWorldSelected)].stringValue == "1"):
					titleString = item + "  ----  " + "Completed Easy"
				
				elif (full.fields['World' + str(global.statWorldSelected)].stringValue == "2"):
					titleString = item + "  ----  " + "Completed Intermediate"
				
				elif (full.fields['World' + str(global.statWorldSelected)].stringValue == "3"):
					titleString = item + "  ----  " + "Completed All"
		
		var titleLength = len(titleString)
		var space = ""
		for i in range(0,(50 - titleLength)):
			space = space + " "
		#titleString = titleString.replace("/",space)
		$TextureRect/MarginContainer/MarginContainer/VBoxContainer/ItemList.add_item(titleString)
	

func _on_Button_pressed():
	if global.customViewingStats:
		get_tree().change_scene("res://View/gameModes/CustomModeAllQuizzes.tscn")
	else:
		get_tree().change_scene("res://View/teachers/ChooseWorldSeeStatsScreen.tscn")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			print("Failure")
		#success
		200:
			var tempStudents = response_body['documents']
			var teacherClassId = ""
			for student in tempStudents:
				teacherClassId = student.name.split("/")[-1]
				if (teacherClassId == global.username):
					teacherClassId = student.fields.classId.integerValue
					break
			
			for student in tempStudents:
				print(student.fields.classId)
				print(student.name.split("/")[-1])
				if (global.accountType == "Admin" || (student.fields.classId.integerValue == teacherClassId && student.name.split("/")[-1] != global.username)):
					students.append(student.name.split("/")[-1])
					$TextureRect/MarginContainer/MarginContainer/VBoxContainer/TitleLabel.text = "ClassId: " + str(student.fields.classId.integerValue)
					classId = student.fields.classId.integerValue
			
			
			totalNumOfStudents = (len(students))
			
			if (totalNumOfCompletions != -1 && totalNumOfStudents>0):
				var percentage = float(totalNumOfCompletions) / float(totalNumOfStudents)
				percentage = percentage * 100
				$TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/ProgressBar.value = percentage
				


func _on_HTTPRequest2_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			print("Failure")
		#success
		200:
			totalNumOfCompletions = 0
			totalScoreCompletions = 0
			var mystudents = ((response_body['documents']))
			yield(get_tree().create_timer(2), "timeout")
			var mystudents2 = []
			for i in range(0,len(mystudents)):
				if (mystudents[i].name.split("/")[-1] in students):
					var resultNum = (mystudents[i]['fields']['World' + str(global.statWorldSelected)]['stringValue'])
					var resultNumInt = int(resultNum)
					if (resultNumInt == 3):
						totalNumOfCompletions = totalNumOfCompletions + 1
					
					var totalScoreNum = int(mystudents[i]['fields']['ScoreWorld' + str(global.statWorldSelected) + 'a']['stringValue'])
					totalScoreNum = totalScoreNum + int(mystudents[i]['fields']['ScoreWorld' + str(global.statWorldSelected) + 'b']['stringValue'])
					totalScoreNum = totalScoreNum + int(mystudents[i]['fields']['ScoreWorld' + str(global.statWorldSelected) + 'c']['stringValue'])
					
					totalScoreCompletions = totalNumOfCompletions + totalScoreNum
					
					mystudents2.append(mystudents[i])
					studentsFullProgressDetails.append(mystudents[i])
			
			constructListWithData(students)
			if (len(mystudents2) != 0):
				totalScoreAverage = float(totalScoreCompletions) / float(len(mystudents))
			$TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/AverageLabel.set_text(str(totalScoreAverage) + "/30")
			if (totalNumOfStudents > 0):
				var percentage = float(totalNumOfCompletions) / float(totalNumOfStudents)
				percentage = percentage * 100
				$TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/ProgressBar.value = percentage


func _on_HTTPRequest3_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			print("Failure")
		200:
			$TextureRect/MarginContainer/MarginContainer/VBoxContainer/ItemList.clear()

			if "documents" in response_body:
				var documents = (response_body['documents'])
				for document in documents:
					var name = (document.name.split("/")[-1])
					var score = str(document.fields.Score.integerValue)
					$TextureRect/MarginContainer/MarginContainer/VBoxContainer/ItemList.add_item(name + "  ---- Score: " + score)
				#Performance Test
				if (testPerformance.performanceCheck):
					print("Performance Test: Statistics Display")
					testPerformance.getTimeTaken()
				
