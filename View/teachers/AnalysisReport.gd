extends Node


# Declare member variables here. Examples:
onready var http:HTTPRequest = $HTTPRequest
onready var http2:HTTPRequest = $HTTPRequest2
var studentsInTheClass = []
var completionArray = []
var averageCompletionRateForAll = 0
var classid = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.get_document("%s" % "users",http)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/ChooseModeToCheckStatsScene.tscn")


func populateItemList():
	for world in range(1,11):
		var label = "World " + str(world) + ": " + str(completionArray[world-1]) + "% completed the world"
		$PlayBoard/VSplitContainer/ItemList.add_item(label)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			print("Failure")
		#success
		200:
			var documents = (response_body['documents'])
			#First step: find teacher id
			classid = ""
			for document in documents:
				var name = document.name.split("/")[-1]
				#name = name.split("@")[0]
				if name == global.username:
					classid = document.fields.classId.integerValue
					break
			
			#Second step: Append all students with the same id
			for document in documents:
				var name = document.name.split("/")[-1]
				var studentclass = document.fields.classId.integerValue
				if studentclass == classid:
					studentsInTheClass.append(name)
					
			
			#Third step: Fetch their score from firebase: 
			Firebase.get_document("%s" % "SaveData",http2)
			


func _on_HTTPRequest2_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			print("Failure")
		#success
		200:
			var documents = (response_body['documents'])
			#Forth step: have to make sure that the student is in this class
			var filteredDocs = []
			for doc in documents:
				if doc.name.split("/")[-1] in studentsInTheClass:
					filteredDocs.append(doc)
			
			#Fifth step: For each world, find the number of ppl completed
			var sum = 0.0
			for world in range(1,11):
				var numberOfCompletions = 0.0
				for doc in filteredDocs:
					var completionStatus = doc.fields['World' + str(world)]['stringValue']
					if completionStatus == "3":
						numberOfCompletions = numberOfCompletions + 1
				completionArray.append(numberOfCompletions * 100 / len(studentsInTheClass))
				sum = sum + numberOfCompletions * 100 / len(studentsInTheClass)
			
			averageCompletionRateForAll = sum / 10
			
			#Sixth Step: Time to populate the itemlist
			populateItemList()
			
			#Seventh Step: Modify the label
			var reportText = ""
			
			if averageCompletionRateForAll < 50:
				reportText = "Gotta work harder!"
			elif averageCompletionRateForAll < 70:
				reportText = "The class is doing pretty well!"
			elif averageCompletionRateForAll < 100:
				reportText = "This class is doing extremely well!"
			
			var labelDescription = "Class: " + global.classArray[int(classid)] + "\n" + "Average Completion: " + str(averageCompletionRateForAll) + "% \n" + reportText
			$PlayBoard/VSplitContainer/AverageCompletionLabel.text = labelDescription

