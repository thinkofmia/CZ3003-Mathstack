extends Node


# Declare member variables here. Examples:
onready var http : HTTPRequest = $HTTPRequest
onready var students = []
var student_info = []
var student_display
var getStudents=false
var getQuiz=false
var qnList

var newButton = load("res://Model/buttons/interface/editQnButtons.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	#Set Header
	$TemplateScreen/Header.set_text(global.worldSelected+": List of Questions")
	#Save Node as question List
	qnList = $PlayBoard/ScrollContainer/qnList
	
	####Requires firebase	
	#Total Number of Questions
	var totalQuestions = 5
	#Loop based on No of questions 
	for i in range (0,totalQuestions):
		#Get Qn Name
		var qnName = "What is 1+"+str(i)+"?" 
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
	if response_code != 200:
		print(response_body)
		print("error!")
	elif response_code == 200:
		if getStudents==true:
			#put dictionary into an array
			self.students = response_body
			
			


func _on_AddButton_pressed():
	get_tree().change_scene("res://View/teachers/AddQnsDetails.tscn")
