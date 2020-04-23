extends Node


onready var http : HTTPRequest = $HTTPRequest
onready var questions = []
var question_info = []
var quizList
var question_display
var getQns=false
var getQuiz=false
var newButton = load("res://Model/buttons/gameModeButtons/CustomQuizButton.tscn")
var Quiz := {
	"Creator":{},
	"Date":{},
	"Id":{},
	"NumQns":{},
	"QuizName":{},
	"World":{}
}


func _ready():
	#Performance Test
	if (testPerformance.performanceCheck):
		testPerformance.startTime()
	#Set Quiz List
	quizList = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes
	#Select Mode
	global.modeSelected = "All Custom"
	getQns=true
	#http call to get all custom quiz
	Firebase.get_document("CustomQuiz", http)
	#yield(get_tree().create_timer(2), "timeout")
	#get values from questions array and put into question_info
	
	#for each questions in the array

	
	#For loop for array of total quizzes player made
	#for i in range(0,myQuizzes.size()):
		#Add new instance
	#	var addButton = newButton.instance()
	#	#Change button name to quiz name
	#	addButton.set_text(myQuizzes[i])
		#Add quiz button to the list
	#	quizList.add_child(addButton)
		
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
			#get values from questions array and put into question_info
			question_info = (questions.values())
			#for each questions in the array
			for i in range(0,question_info[0].size()):
				#extract question attribute based on i
				question_display= (question_info[0][i]['fields'])
				#print(str(question_display['QuizName'].values()[0]))
				#Add new instance
				var addButton = newButton.instance()
				#Change button name to quiz name
				addButton.set_text(str(question_display['QuizName'].values()[0]))
				#Add quiz button to the list
				quizList.add_child(addButton)
			getQns=false
			#Performance Test
			if (testPerformance.performanceCheck):
				print("Performance Test: Custom Mode All Quiz Display")
			testPerformance.getTimeTaken()
		#print("Accessed succesfully")
		
