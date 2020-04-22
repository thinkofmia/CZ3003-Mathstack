extends Node

onready var http : HTTPRequest = $PlayBoard/MarginContainer/VBoxContainer/QnList/HTTPRequest
onready var qText : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/QnTextRow/LineEdit
onready var op1 : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/Option1Row/LineEdit
onready var op2 : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/Option2Row/LineEdit
onready var op3 : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/Option3Row/LineEdit
onready var op4 : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/Option4Row/LineEdit
onready var ans : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/CorrectAns/LineEdit

var information_sent = false
var get_info = false
var newQn = false
var delete = false

onready var questions = []
var question_info = []
var question_display
var getID
var table
var d

#Variables for screen
onready var difficultySelected = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/DifficultyRow/DifficultyOption
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

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/QnTextRow/QnTextLabel.hide()
	$SaveButton/Label.set_text("save")
	$TextDisplay.hide()
	hideButtons()
	#Set difficulty node
	addDifficultyOptions()
	#If saving difficulty too hard, set it as easy by default
	#print(global.selectQn)
	#var getQuestions=global.difficulty+"World"+global.worldSelected.substr(7,1)
	get_info = true 
	table ="NormalWorld"+global.worldSelected.substr(7,2)
	Firebase.get_document(table, http)
	yield(get_tree().create_timer(2), "timeout")
	question_info = (questions.values())
	#Total Number of Questions
	var totalQuestions = question_info[0].size()
	#Loop based on No of questions 
	for i in range (0,totalQuestions):
		#extract question attribute based on i
		question_display= (question_info[0][i]['fields'])
		#Get Qn Name
		var qnName = str(question_display['QuestionText'].values()[0])
		if qnName == global.selectQn:
			qText.text = str(question_display['QuestionText'].values()[0])
			op1.text = str(question_display['Option1'].values()[0])
			op2.text = str(question_display['Option2'].values()[0])
			op3.text = str(question_display['Option3'].values()[0])
			op4.text = str(question_display['Option4'].values()[0])
			ans.text = str(question_display['Ans'].values()[0])
			getID = question_info[0][i]['name']
			var a = getID.find_last("-")
			d = getID.substr(a-1,1)
			match d:
				"A":difficultySelected.select(2)
				"I":difficultySelected.select(1)
				"E":difficultySelected.select(0)
	showButtons()			

func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/SelectQuestion.tscn")

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	if response_code==200:
		var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
		if get_info:
			self.questions = result_body
			get_info = false
		if information_sent:
			information_sent = false
		if newQn:
			newQn=false
		if delete:
			delete=false
	else:
		return


func _on_SaveButton_pressed():
	#Display pop up after play button is pressed
	displayPopup()
	print(table)
	Question.QuestionText = { "stringValue": qText.text }
	Question.Option1 = { "stringValue": op1.text }
	Question.Option2 = { "stringValue": op2.text }
	Question.Option3 = { "stringValue": op3.text }
	Question.Option4 = { "stringValue": op4.text }
	Question.Ans = { "stringValue": ans.text }
	var z = difficultySelected.get_selected_id()
	var x = difficultySelected.get_item_text(z).substr(0,1)
	var a = getID.find_last("/")
	var b = getID.find_last("-")
	var ID = getID.substr(a+1,b+2-a)
	var format_string = "%s/%s"
	var actual_string = format_string % [table,ID]
	if (x==d):
		#http request to update user profile
		print(actual_string)
		information_sent = true
		Firebase.update_document(actual_string, Question, http)
		yield(get_tree().create_timer(2), "timeout")
		
	else:
		var s = "%s?documentId=DM-N-%s-%s-%s"
		var world 
		if int(global.worldSelected.substr(7,2))<10:
			 world = "0"+global.worldSelected.substr(7,2)
		else:
			 world =global.worldSelected.substr(7,2)
		var s2= s % [table,world,x,getID.substr(b+1,2)]
		newQn = true
		Firebase.save_document(s2, Question, http)
		yield(get_tree().create_timer(2), "timeout")
		delete = true
		print(actual_string)
		Firebase.delete_document(actual_string,http)
		yield(get_tree().create_timer(2), "timeout")
	
	
func displayPopup():
	#Hide board
	$PlayBoard.hide()
	#Show display
	$TextDisplay.show()
	hideButtons()
	yield(get_tree().create_timer(6), "timeout")
	_on_BackButton_pressed()

func showButtons():
	#Show buttons
	$BackButton.show()
	$SaveButton.show()
	$DeleteButton.show()

func hideButtons():
	#Hide buttons
	$BackButton.hide()
	$SaveButton.hide()
	$DeleteButton.hide()

func _on_DeleteButton_pressed():
	var a = getID.find_last("/")
	var b = getID.find_last("-")
	var ID = getID.substr(a+1,b+2-a)
	var format_string = "%s/%s"
	var actual_string = format_string % [table,ID]
	Firebase.delete_document(actual_string,http)
	#Display pop up after play button is pressed
	$TextDisplay.set_text("Deleted! D: ")
	displayPopup()
