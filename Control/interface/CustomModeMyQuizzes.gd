extends Node

#Firebase Vars
onready var http : HTTPRequest = $HTTPRequest
onready var questions = []
var question_info = []
var getQns=false
var question_display

#Main vars
var myQuizzes = ["Custom Quiz 1","Faker","ADD ME"]
onready var quizList = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes #Get quiz list node
onready var newButton = load("res://Model/buttons/gameModeButtons/CustomQuizButton.tscn") #Set instance button

# Called when the node enters the scene tree for the first time.
func _ready():
	if (testPerformance.performanceCheck):#Performance Test
		testPerformance.startTime()
	global.modeSelected = "My Custom" #Set mode selected to be my custom quiz
	$AddButton/Label.set_text("Add") #Set label of add button	
	getQns=true #Set get question boolean as true
	Firebase.get_document("CustomQuiz", http)#http call to get all custom quiz
	yield(get_tree().create_timer(2), "timeout") #Set time out 2 sec
	question_info = (questions.values())#get values from custom quiz array and put into container
	for i in range(0,question_info[0].size()):#for each custom quiz in the array
		question_display= (question_info[0][i]['fields'])#extract custom quiz attribute based on i
		if str(question_display['Creator'].values()[0]) == global.username: #check if the quiz is created by the user
			var addButton = newButton.instance()#Add new instance
			addButton.set_text(question_display['QuizName'].values()[0])#Change button name to quiz name
			quizList.add_child(addButton)#Add quiz button to the list
	if (testPerformance.performanceCheck):#Performance Test
		print("Performance Test: Custom Mode My Quiz Display")
		testPerformance.getTimeTaken()

#If Add Button is pressed
func _on_AddButton_pressed():
	global.customTitle="" #Set custom title to be null
	get_tree().change_scene("res://View/gameModes/CustomModeEdit.tscn")#Go to create new quiz scene

#Firebase request
func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	#conver json into a dictionary
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		return
		#print(response_body)
		#print("error!")
	elif response_code == 200:
		if getQns==true:
			#put dictionary into an array
			self.questions = response_body
