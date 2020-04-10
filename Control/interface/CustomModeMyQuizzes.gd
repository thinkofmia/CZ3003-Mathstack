extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var http : HTTPRequest = $HTTPRequest
onready var questions = []
var myQuizzes = ["Custom Quiz 1","Faker","ADD ME"]
var quizList 
var question_info = []
var question_display
var getQns=false
var addButton 
# Called when the node enters the scene tree for the first time.
func _ready():
	#Set mode selected to be my custom quiz
	global.modeSelected = "My Custom"
	#Set Quiz List
	quizList = $PlayBoard/MarginContainer/VBoxContainer/ScrollContainer/ListOfAvailableQuizzes
	#Load Button Object
	$AddButton/Label.set_text("Add")
	var newButton = load("res://Model/buttons/gameModeButtons/CustomQuizButton.tscn")
	getQns=true
	#http call to get all questions
	Firebase.get_document("CustomQuiz", http)
	yield(get_tree().create_timer(2), "timeout")
	#get values from questions array and put into question_info
	question_info = (questions.values())
	#for each questions in the array
	for i in range(0,question_info[0].size()):
		#extract question attribute based on i
		question_display= (question_info[0][i]['fields'])
		if str(question_display['Creator'].values()[0]) == global.username:
			print(str(question_display['QuizName'].values()[0]))
			#Add new instance
			addButton = newButton.instance()
			#Change button name to quiz name
			addButton.set_text(question_display['QuizName'].values()[0])
			#Add quiz button to the list
			quizList.add_child(addButton)
	
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


func _on_AddButton_pressed():
	#var a = addButton.get_text()
	if addButton!=null:
		global.customTitle=addButton.get_text()
	get_tree().change_scene("res://View/gameModes/CustomModeEdit.tscn")


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	#conver json into a dictionary
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		print(response_body)
		print("error!")
	elif response_code == 200:
		if getQns==true:
			#put dictionary into an array
			self.questions = response_body
