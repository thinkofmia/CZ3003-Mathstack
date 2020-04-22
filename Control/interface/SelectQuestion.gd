extends Node
onready var http : HTTPRequest = $HTTPRequest
onready var questions = []
var getQuestions=false
var question_info = []
var question_display
var getQuiz=false
var qnList
var addButton 

var newButton = load("res://Model/buttons/interface/editQnButtons.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Header
	$TemplateScreen/Header.set_text(global.worldSelected+": List of Questions")
	#Save Node as student List
	qnList = $PlayBoard/ScrollContainer/qnList
	
	####Requires firebase	
	getQuestions=true
	var table ="NormalWorld"+global.worldSelected.substr(7,2)
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
		#Add new instance
		var addButton = newButton.instance()
		#Change button name to quiz name
		addButton.set_text(qnName)
		#Add qn button to the list
		qnList.add_child(addButton)

func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/AddQnsSelectWorld.tscn")

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code == 200:
		if getQuestions==true:
			#put dictionary into an array
			self.questions = response_body

func _on_AddButton_pressed():
	#global.selectQn=addButton.get_text()
	get_tree().change_scene("res://View/teachers/AddQnsDetails.tscn")
