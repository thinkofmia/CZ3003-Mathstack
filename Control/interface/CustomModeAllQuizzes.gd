extends Node


onready var http : HTTPRequest = $HTTPRequest
onready var btn1 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton
onready var btn2 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton2
onready var btn3 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton3
onready var btn4 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton4
onready var btn5 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton5
onready var btn6 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton6
onready var btn7 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton7
onready var btn8 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton8
onready var btn9 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton9
onready var btn10 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton10
onready var btn11 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton11
onready var btn12 : Button = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes/CustomQuizButton12
onready var questions = []
onready var btnGroup=[btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,btn10,btn11,btn12]
var question_info = []
var question_display
var getQns=false
var getQuiz=false
var Quiz := {
	"Creator":{},
	"Date":{},
	"Id":{},
	"NumQns":{},
	"QuizName":{},
	"World":{}
}
func _ready():
	global.modeSelected = "All Custom"
	getQns=true
	#http call to get all questions
	Firebase.get_document("CustomQuiz", http)
	yield(get_tree().create_timer(2), "timeout")
	#get values from questions array and put into question_info
	question_info = (questions.values())
	#for each questions in the array
	for i in range(0,question_info[0].size()+1):
		#extract question attribute based on i
		question_display= (question_info[0][i]['fields'])
		print(str(question_display['QuizName'].values()[0]))
		#Change button name to quiz name
		btnGroup[i].text= str(question_display['QuizName'].values()[0])
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		print(response_body)
		print("error!")
	elif response_code == 200:
		if getQns==true:
			#put dictionary into an array
			self.questions = response_body
			getQns=false
		print("Accessed succesfully")
