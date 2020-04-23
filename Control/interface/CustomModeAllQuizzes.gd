extends Node

#Firebase var
onready var http : HTTPRequest = $HTTPRequest #Node for firebase linking
onready var questions = [] #Questions array
var question_info = [] #Question information fields
var getQns=false
var getQuiz=false

onready var quizList = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes #Quiz list
var question_display #Question title label
var newButton = load("res://Model/buttons/gameModeButtons/CustomQuizButton.tscn") #Instance of new button

var Quiz := { #Quiz details
	"Creator":{},
	"Date":{},
	"Id":{},
	"NumQns":{},
	"QuizName":{},
	"World":{}
}

func _ready(): #On start
	if (testPerformance.performanceCheck):#Conduct performance test if true
		testPerformance.startTime()
	global.modeSelected = "All Custom" #Set Mode as All Custom
	getQns=true #Get question boolean set to true
	
	Firebase.get_document("CustomQuiz", http)#http call to get all custom quiz

#Firebase received request
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
