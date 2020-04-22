extends Node

onready var http : HTTPRequest = $HTTPRequest
onready var qText : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/QnTextRow/LineEdit
onready var op1 : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/Option1Row/LineEdit
onready var op2 : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/Option2Row/LineEdit
onready var op3 : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/Option3Row/LineEdit
onready var op4 : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/Option4Row/LineEdit
onready var ans : LineEdit = $PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/CorrectAns/LineEdit

var information_sent = false
var get_info = false

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
} setget set_question

func addDifficultyOptions(): #Add scroll down box
	for item in difficultyArr:
		difficultySelected.add_item(item)

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayBoard/MarginContainer/VBoxContainer/QnList/Qn1/QnTextRow/QnTextLabel.hide()
	
	#Set difficulty node
	addDifficultyOptions()
	#If saving difficulty too hard, set it as easy by default
	
	#var getQuestions=global.difficulty+"World"+global.worldSelected.substr(7,1)
	get_info = true
	
	#var questionId
	#format_string = "%s?documentId=%s"
	#actual_string = format_string % [getQuestions,questionId]
	#Firebase.get_document(actual_string, http)
	#Firebase.get_document("NormalWorld1/test", http)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/SelectQuestion.tscn")


func _on_HTTPRequest_request_completedd(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code==200:
		if get_info:
			self.Question = result_body.fields
			get_info = false
		if information_sent:
			information_sent = false
	else:
		return
		
func set_question(value: Dictionary) -> void:
	#display the profile attributes
	Question = value
	qText.text = str(Question.QuestionText.stringValue)
	op1.text = str(Question.Option1.stringValue)
	op2.text = str(Question.Option2.stringValue)
	op3.text = str(Question.Option3.stringValue)
	op4.text = str(Question.Option4.stringValue)
	ans.text = str(Question.Answer.stringValue)
	#account.text = "Account: %s" % str(profile.account.stringValue)
	#nickname.text=profile.nickname.stringValue
	#school.text = "School: %s" % str(school_array[int(profile.schoolId.integerValue)])
	#classId = profile.classId.integerValue
	#class1.select(int(classId))


func _on_Button_pressed():
	Question.QuestionText = { "stringValue": qText.text }
	Question.Option1 = { "stringValue": op1.text }
	Question.Option2 = { "stringValue": op2.text }
	Question.Option3 = { "stringValue": op3.text }
	Question.Option4 = { "stringValue": op4.text }
	ans.Option1 = { "stringValue": ans.text }
	#http request to update user profile
	Firebase.update_document("NormalWorld1/test", Question, http)
	information_sent = true
