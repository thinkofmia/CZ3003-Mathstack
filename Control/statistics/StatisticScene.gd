extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var http : HTTPRequest = $HTTPRequest
onready var http2 : HTTPRequest = $HTTPRequest2
var totalNumOfStudents = -1
var totalNumOfCompletions = -1
var totalScoreCompletions = -1
var totalScoreAverage = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.get_document("%s" % "users", http)
	Firebase.get_document("%s" % "SaveData",http2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	get_tree().change_scene("res://View/teachers/ChooseWorldSeeStatsScreen.tscn")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			print("Failure")
		#success
		200:
			totalNumOfStudents = (len(response_body['documents']))
			if (totalNumOfCompletions != -1):
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
			var students = ((response_body['documents']))
			for i in range(0,len(students)):
				var resultNum = (students[i]['fields']['World' + str(global.statWorldSelected)]['stringValue'])
				var resultNumInt = int(resultNum)
				if (resultNumInt == 3):
					totalNumOfCompletions = totalNumOfCompletions + 1
				
				var totalScoreNum = int(students[i]['fields']['ScoreWorld' + str(global.statWorldSelected) + 'a']['stringValue'])
				totalScoreNum = totalScoreNum + int(students[i]['fields']['ScoreWorld' + str(global.statWorldSelected) + 'b']['stringValue'])
				totalScoreNum = totalScoreNum + int(students[i]['fields']['ScoreWorld' + str(global.statWorldSelected) + 'c']['stringValue'])
				
				totalScoreCompletions = totalNumOfCompletions + totalScoreNum
			
			totalScoreAverage = float(totalScoreCompletions) / float(len(students))
			$TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/AverageLabel.set_text(str(totalScoreAverage) + "/30")
			if (totalNumOfStudents != -1):
				var percentage = float(totalNumOfCompletions) / float(totalNumOfStudents)
				percentage = percentage * 100
				$TextureRect/MarginContainer/MarginContainer/VBoxContainer/GridContainer/ProgressBar.value = percentage
