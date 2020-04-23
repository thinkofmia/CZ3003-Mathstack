extends Node

#Firebase vars
onready var http : HTTPRequest = $HTTPRequest
onready var students = []
var student_info = []
var student_display
var getStudents=false
var getQuiz=false

onready var qnList = $PlayBoard/ScrollContainer/qnList #Get qn list node
onready var header = $TemplateScreen/Header #Get header node
var newButton = load("res://Model/buttons/interface/editQnButtons.tscn") #Set instance

# Called when the node enters the scene tree for the first time.
func _ready():
	header.set_text(global.worldSelected+": List of Questions")#Set Header text
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

#Go back to select world scene
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/AddQnsSelectWorld.tscn")

#Firebase request
func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	if response_code != 200:
		print(response_body)
		print("error!")
	elif response_code == 200:
		if getStudents==true:
			#put dictionary into an array
			self.students = response_body
			
#Go to add question details scene
func _on_AddButton_pressed():
	get_tree().change_scene("res://View/teachers/AddQnsDetails.tscn")
