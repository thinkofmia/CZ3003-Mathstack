extends Node


# FIrebase var
onready var http : HTTPRequest = $HTTPRequest
onready var students = []
var student_info = []
var student_display
var getStudents=false
var getQuiz=false

onready var studentList = $PlayBoard/ScrollContainer/ListOfStudents #Set student list node
var newButton = load("res://Model/buttons/interface/userStatsButtons.tscn") #Set new button instance

# Called when the node enters the scene tree for the first time.
func _ready():
	global.targetType = "Student"	#Set Target type as Student
	#Firebase func
	getStudents=true
	Firebase.get_document("users", http)
	yield(get_tree().create_timer(5.0), "timeout") #Timeout for 5secs
	#Total Number of Teachers
	student_info = (students.values())
	var totalNoUsers = student_info[0].size()
	#Loop based on No of students 
	for i in range (0,totalNoUsers):
		#extract question attribute based on i
		student_display= (student_info[0][i]['fields'])
		print(str(student_display['account'].values()[0]))
		var temp = student_info[0][i]['name']
		temp = temp.right(61)
		if student_display['account'].values()[0] == "Student":
				#Add new instance
				var addButton = newButton.instance()
				#Change button name to quiz name
				addButton.set_text(str(temp))
				#Add quiz button to the list
				studentList.add_child(addButton)

#Go back to normal mode option scene
func _on_BackButton_pressed():
	get_tree().change_scene("res://View/teachers/NormalModeOptions.tscn")

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
