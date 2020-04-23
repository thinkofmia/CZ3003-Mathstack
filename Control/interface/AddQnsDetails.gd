extends Node

onready var http : HTTPRequest = $HTTPRequest
onready var difficultySelected = $PlayBoard/MarginContainer/VBoxContainer/Container/QnList/Qn1/DifficultyRow/DifficultyOption

#Variables
var totalQn = 1 #Total No of Qn
var newQnSet
var qnList
var dID
var difficulty
var d
var difficultyArr = ["Easy","Intermediate","Advanced"]
var Question := {
	"QuestionText":{},
	"Option1":{},
	"Option2":{},
	"Option3":{},
	"Option4":{},
	"Ans":{}
}

func addDifficultyOptions(): #Add scroll down box
	for item in difficultyArr:
		difficultySelected.add_item(item)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayBoard/MarginContainer/VBoxContainer/Label.set_text(global.worldSelected)
	$PopUpControl.hide()
	totalQn = 1 #Get total number of qns here
	$ConfirmButton/Label.set_text("Save") #Replace Edit Button with Confirm Button
	newQnSet = load("res://View/util/customQuestionSet.tscn") #Sets Merged scene as custom Qn Set
	qnList = $PlayBoard/MarginContainer/VBoxContainer/Container/QnList
	addDifficultyOptions()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_AddButton_pressed():
	totalQn +=1
	#Add new instance
	var addQn = newQnSet.instance()
	#Change Question Name with its number
	addQn.get_child(0).get_child(0).set_text("Qn #"+str(totalQn)+": ")
	#Add qn to the list
	qnList.add_child(addQn)
	

func hideButtons():
	$BackButton.hide()
	$AddButton.hide()
	$ConfirmButton.hide()

func _on_ConfirmButton_pressed():
	#Qn saved
	$PopUpControl.show()
	hideButtons()
	#Added qn stuff
	var getQuestions="NormalWorld"+global.worldSelected.substr(7,2)
	for i in range(1,totalQn+1): #Loop For Total Number of Qn 
		#print(i)
		var qnSet = qnList.get_child(i-1) #Save as qn set
		var qnTitle = qnSet.get_child(0).get_child(1).get_text() #Qn Title
		#skip if question title is empty
		if qnTitle == "":
			continue
		var option1 = qnSet.get_child(1).get_child(1).get_text() #Option 1
		var option2 = qnSet.get_child(2).get_child(1).get_text() #Option 2
		var option3 = qnSet.get_child(3).get_child(1).get_text() #Option 3
		var option4 = qnSet.get_child(4).get_child(1).get_text() #Option 4
		var ans = qnSet.get_child(5).get_child(1).get_text() #Option 1
		#Set Question attributes
		Question.QuestionText={"stringValue": qnTitle}
		Question.Option1={"stringValue": option1}
		Question.Option2={"stringValue": option2}
		Question.Option3={"stringValue": option3}
		Question.Option4={"stringValue": option4}
		Question.Ans={"stringValue": ans}
		#set difficulty
		dID = difficultySelected.get_selected_id()
		difficulty = difficultySelected.get_item_text(dID)
		match difficulty:
			"Easy":d="E"
			"Intermediate":d="I"
			"Advanced":d="A"
		#format question id
		var format_string = "%s?documentId=DM-N-%s-%s-%s"
		var random = int(floor(rand_range(0,100)))
		var world
		if int(global.worldSelected.substr(7,2))<10:
			world = "0"+global.worldSelected.substr(7,2)
		else:
			world =global.worldSelected.substr(7,2)
		#format request string
		var actual_string = format_string % [getQuestions,world,d,random]
		#http request to save the question
		Firebase.save_document(actual_string, Question, http)
		yield(get_tree().create_timer(2.0), "timeout")
	_on_BackButton_pressed()	


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	print(result_body)
	print(response_code)
	match response_code:
		#error
		404:
			return
		#success
		200:
			return


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/SelectQuestion.tscn")


func _on_QuitButton_pressed():
	$PopUpControl.hide()
